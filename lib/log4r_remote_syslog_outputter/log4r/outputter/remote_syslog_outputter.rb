require 'log4r/outputter/outputter'
require 'remote_syslog_logger/udp_sender'

module Log4r
  class RemoteSyslogOutputter < Log4r::Outputter
    def initialize(name, host, port, options = {})
      level = options.delete(:level)
      formatter = options.delete(:formatter)

      super(name, {:level => level, :formatter => formatter})

      @udp_sender = RemoteSyslogLogger::UdpSender.new(host, port, options)
    end

    private
    def write(data)
      @udp_sender.write(data)
    end
  end
end
