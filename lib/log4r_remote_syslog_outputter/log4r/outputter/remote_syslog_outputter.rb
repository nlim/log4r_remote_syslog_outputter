require 'log4r/outputter/outputter'
require 'remote_syslog_logger/udp_sender'

module Log4r
  class RemoteSyslogOutputter < Log4r::Outputter
    def initialize(name, host, port, options = {})
      options.dup.tap do |o|
        super(name, [:level, :formatter].inject({}) { |h, i| h.tap { |a| a[i] = o.delete(i)) } })
        @udp_sender = RemoteSyslogLogger::UdpSender.new(host, port, o)
      end
    end

    private
    def write(data)
      @udp_sender.write(data)
    end
  end
end
