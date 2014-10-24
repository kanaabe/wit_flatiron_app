class WitController
  
  def try
    access_token = 'M36WCGPCW2YWJ7SASA75AUOO2P3ZZZDW'

    Wit.init
    response = Wit.voice_query_auto(access_token)
    p "Response: #{response}"
    Wit.close

  end
end