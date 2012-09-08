require 'spec_helper'

describe Log4r::RemoteSyslogOutputter do
  
  let(:name) { 'name' }
  let(:url)  { 'http://localhost:65535' }
  let(:uri)  { URI.parse(url) }
  let(:host) { uri.host }
  let(:port) { uri.port }

  describe '#initialize' do

    subject { Log4r::RemoteSyslogOutputter }

    it 'should create a new RemoteSyslogLogger::UdpSender' do
      RemoteSyslogLogger::UdpSender
        .should_receive(:new)
        .with(host, port, {})

      subject.new(name, 'url' => url)
    end

    it "should not pass along :level and :formatter, and 'url' to RemoteSyslogLogger::UdpSender's constructor" do
      RemoteSyslogLogger::UdpSender
        .should_receive(:new)
        .with(host, port, :key => 'value')

      subject.new(name, 'url' => url, :level => nil, :formatter => nil, :key => 'value')
    end

    it "should symbolize the extra keys" do
      RemoteSyslogLogger::UdpSender
        .should_receive(:new)
        .with(host, port, :program => 'value')

      subject.new(name, 'url' => url, :level => nil, :formatter => nil, 'program' => 'value')

    end

    it 'should not modify the input options hash, using a duplicate' do
      options = {'url' => url, :level => nil, :formatter => nil}
      orig_options = options.dup

      RemoteSyslogLogger::UdpSender.should_receive(:new)

      subject.new(name, options)

      options.should == orig_options
    end
  end

  describe '#write' do
    let(:udp_sender) { stub }
    let(:data) { stub }

    subject { Log4r::RemoteSyslogOutputter.new(name, 'url' => url) }

    it 'should delegate to udp_sender#write' do
      RemoteSyslogLogger::UdpSender.stub!(:new).and_return(udp_sender)

      udp_sender.should_receive(:write).with(data)

      subject.send(:write, data)
    end
  end

  describe 'Creating via a configuration file' do
    it 'should work with a YAML config file'

    it 'should work with an XML config file'

  end
end
