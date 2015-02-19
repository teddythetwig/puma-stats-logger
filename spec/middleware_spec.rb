require 'spec_helper'

describe PumaStatsLogger::Middleware do
  include Rack::Test::Methods

  class SampleApplication
    def call(env)
      [200, {}, ""]
    end
  end

  let(:app) { PumaStatsLogger::Middleware.new(SampleApplication.new, logger: logger) }
  let(:logger) { Logger.new(log_output)}
  let(:log_output) { StringIO.new }

  context 'when a Puma state file exists' do
    before do
      FileUtils.cp './spec/files/puma.state', 'tmp/puma.state'

      # stub what the Puma stats server would return
      expect(Socket).to receive(:unix).with('/var/folders/_h/30bzldts3gj3n2tknnzcqsl40000gn/T/puma-status-1401402163005-57709').and_return(
        "HTTP/1.0 200 OK\r\nContent-Type: application/json\r\nConnection: close\r\nContent-Length: 30\r\n\r\n{ \"backlog\": 0, \"running\": 1 }"
      )
    end

    after do
      FileUtils.rm './tmp/puma.state'
    end

    it "outputs the puma stats" do
      get "/"
      expect(log_output.string).to include('measure#puma.backlog=0 measure#puma.running=1')
    end

    it "includes Heroku dyno information" do
      ENV['DYNO'] = 'web.1'
      get "/"
      expect(log_output.string).to include('source=web.1')
    end
  end

  context 'when a Puma state file does not exist' do
    it "does nothing" do
      get "/"
      expect(log_output.string).to be_empty
    end
  end
end