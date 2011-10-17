require 'spec_helper'

describe Log4r::Logger do
  describe 'with RemoteSyslogOutputter' do
    let(:host) { 'localhost' }
    let(:port) { rand(65535 - 1024) + 1024 }
    let(:outputter) { Log4r::RemoteSyslogOutputter.new('outputter', host, port) }
    let(:socket) { UDPSocket.new }

    subject { Log4r::Logger.new('Logger') }

    before(:each) do
      subject.outputters << outputter
      socket.bind(host, port)
    end

    it 'should make a UDP request to localhost' do
      subject.info 'Info'
      message, = socket.recvfrom(1024)
      message.should =~ /Logger.*Info/
    end
  end
end
