# Looks for someone saying SRE and then pages the current on call Engineer
class Robut::Plugin::SRE
  include Robut::Plugin

  # Returns a description of how to use this plugin
  def usage
    "Pings the Engineer on duty when someone says SRE"
  end
  
  # Listen for hotword and ping
  def handle(time, sender_nick, message)
    if words(message).first == 'SRE' || words(message).first == 'sre'
        reply("@JoshCampbell")
    end
  end

end
