class WitHandler
  
  @@api_url = "https://api.wit.ai/message"
  @@access_token = 'M36WCGPCW2YWJ7SASA75AUOO2P3ZZZDW'

  # def initialize
  #   Wit.init
  # end

  def message
    Wit.init

    Wit.voice_query_start(@@access_token)
    sleep 3
    r = Wit.voice_query_stop

    Wit.close

    r

  end

end