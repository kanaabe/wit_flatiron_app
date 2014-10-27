class WitHandler
  
  @@api_url = "https://api.wit.ai/message"
  @@access_token = 'IOQ7AJOACSNJ6TH2KIT22E2KHAVKTMML'

  def get_intent
    Wit.init

    Wit.voice_query_start(@@access_token)
    sleep 3
    r = Wit.voice_query_stop
    Wit.close

    response_hash = JSON.parse(r)

  end

  def pull_profile(intent)
    name = parse_name(intent)
    profile = Profile.find_by(:name => name)
  end

  def parse_name(intent)
    intent = intent.gsub("get_","").gsub("_profile","").split("_")
    intent.map { |i| i.capitalize }.join(' ')
  end

end