require 'log4r/outputter/outputter'
require 'remote_syslog_logger/udp_sender'
require 'uri'

module Log4r
  class RemoteSyslogOutputter < Log4r::Outputter
    # The url is required here but it has to be specified
    # as an option (not a parameter) because that's the only
    # way it can be created from a configuration file.
    #   :url  is given when an XML configuration file is used
    #   'url' is given when a YAML configuration file is used
    def initialize(name, options = {})
      url =   options['url']
      url ||= options[:url]
      uri = URI.parse(url)
      options.dup.tap do |o|
        super(name, [:level, :formatter, :url, 'url'].inject({}) { |h, i| 
          h.tap { |a| 
            a[i] = o.delete(i) 
          } 
        })
        @udp_sender = RemoteSyslogLogger::UdpSender.new(uri.host, uri.port, symbolize_keys(o))
      end
    end
    private

    def write(data)
      @udp_sender.write(data)
    end

    def symbolize_keys(hash)
      output = {}
      hash.each do |key, value|
        output[key.to_sym] = value
      end
      output
    end

  end
end
