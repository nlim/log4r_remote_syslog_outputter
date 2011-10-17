require 'log4r/outputter/outputter'
require 'remote_syslog_logger/udp_sender'

module Log4r
  class RemoteSyslogOutputter < Log4r::Outputter
    def initialize(*args)
      @udp_sender = RemoteSyslogLogger::UdpSender.new(*args)
    end

    private
    def write(data)
      @udp_sender.write(data)
    end
  end
end
