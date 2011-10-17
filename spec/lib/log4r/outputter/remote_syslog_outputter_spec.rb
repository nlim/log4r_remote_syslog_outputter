require 'spec_helper'

describe Log4r::RemoteSyslogOutputter do
  describe '#initialize' do
    let(:name) { 'name' }
    let(:host) { 'host' }
    let(:port) { 65535 }

    subject { Log4r::RemoteSyslogOutputter }

    it 'should create a new RemoteSyslogLogger::UdpSender' do
      RemoteSyslogLogger::UdpSender.
        should_receive(:new).
        with(host, port, {})

      subject.new(name, host, port)
    end

    it "should not pass along :level and :formatter to RemoteSyslogLogger::UdpSender's constructor" do
      RemoteSyslogLogger::UdpSender.
        should_receive(:new).
        with(host, port, :key => 'value')

      subject.new(name, host, port, :level => nil, :formatter => nil, :key => 'value')
    end

    it 'should not modify the input options hash' do
      options = {:level => nil, :formatter => nil}
      orig_options = options.dup

      RemoteSyslogLogger::UdpSender.
        should_receive(:new)

      subject.new(name, host, port, options)

      options.should == orig_options
    end
  end

  describe '#write' do
    let(:udp_sender) { stub }
    let(:data) { stub }

    subject { Log4r::RemoteSyslogOutputter.new('', nil, nil) }

    it 'should delegate to udp_sender#write' do
      RemoteSyslogLogger::UdpSender.stub!(:new).and_return(udp_sender)

      udp_sender.should_receive(:write).with(data)

      subject.send(:write, data)
    end
  end
end
