require 'spec_helper'

describe Log4r::Logger do
  describe 'with RemoteSyslogOutputter' do
    let(:port) { rand(65535 - 1024) + 1024 }
    let(:outputter) { Log4r::RemoteSyslogOutputter.new('outputter', '127.0.0.1', port) }
    let(:socket) { UDPSocket.new }

    subject { Log4r::Logger.new('Logger') }

    before(:each) do
      subject.outputters << outputter
      socket.bind('127.0.0.1', port)
    end

    it 'should make a UDP request to localhost' do
      subject.info 'Info'
      message, = socket.recvfrom(1024)
      message.should =~ /Logger.*Info/
    end
  end
end
