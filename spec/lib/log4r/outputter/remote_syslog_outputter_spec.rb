require 'spec_helper'

describe Log4r::RemoteSyslogOutputter do
  describe '#write' do
    describe 'unit' do
      let(:udp_sender) { stub }
      let(:data) { stub }

      subject { Log4r::RemoteSyslogOutputter.new }

      it 'should delegate to udp_sender#write' do
        RemoteSyslogLogger::UdpSender.
          should_receive(:new).
          and_return(udp_sender)

        udp_sender.should_receive(:write).with(data)

        subject.send(:write, data)
      end
    end
  end
end
