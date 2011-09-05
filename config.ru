require ::File.join( ::File.dirname(__FILE__), 'app' )


if ENV['RACK_ENV'] == "production"
  require "remote_syslog_logger"
  @current_path = File.expand_path(File.dirname(__FILE__))
  require "#{@current_path}/lib/remote_syslog"

  LOGGER = RemoteSyslog.new(Settings.remote_log_host,Settings.remote_log_port)
  use Rack::CommonLogger, LOGGER
else
  LOGGER = Logger.new("log/#{ENV['RACK_ENV']}.log")
	use Rack::CommonLogger, LOGGER
end

class Logger
  def write(msg)
    LOGGER.info(msg)
  end
end
run MyApp.new