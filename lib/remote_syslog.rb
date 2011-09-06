require "remote_syslog_logger"
class RemoteSyslog
  def initialize(host, port)
    @logger = RemoteSyslogLogger.new(host, port, {:program => 'www_sol'})
  end

  def write(str)
    @logger.info(str)
  end
end