
  ###IDENTIFICATION
    def identifySpeaker
        audiofile = File.open("app/assets/audio/test.wav") ##File.open("app/assets/audio/#{audioFileLoaded}")
        speaker = Excon.post('https://eastus.api.cognitive.microsoft.com/speaker/identification/v2.0/text-independent/profiles/identifySingleSpeaker?profileIds={profileIds}',
        headers:{
            'Content-Type' => 'audio/wave',
            'Ocp-Apim-Subscription-Key' => "#{ENV['AZURE_KEY']}"
        },
        body: audiofile,
      )
      return speaker.body
    end

    def createEnroll
        audiofile = File.open("app/assets/audio/test.wav") ##File.open("app/assets/audio/#{audioFileLoaded}")
        enroll = Excon.post('https://eastus.api.cognitive.microsoft.com/speaker/identification/v2.0/text-independent/profiles/{profileId}/enrollments',
        headers: {
            'Content-Type' => 'audio/wave',
            'Ocp-Apim-Subscription-Key' => "#{ENV['AZURE_KEY']}"
        },
        body: audiofile
     )
      return enroll.body
    end

    def createProfile
      connection =
        Excon.post(
          'https://eastus.api.cognitive.microsoft.com/speaker/identification/v2.0/text-independent/profiles',
          headers: {
            'Content-Type' => 'application/json',
            'Ocp-Apim-Subscription-Key' => "#{ENV['AZURE_KEY']}"
          },
          body: JSON.generate("locale": 'en-us')
        )
      return connection.body
    end

    def getProfile
      profil =
        Excon.get(
          'https://eastus.api.cognitive.microsoft.com/speaker/identification/v2.0/text-independent/profiles/"dc53bdab-feef-4310-aefd-b5f8581ddd6e",',
          headers: {
            'Content-Type' => 'application/json',
            'Ocp-Apim-Subscription-Key' => "#{ENV['AZURE_KEY']}"
          },
          body: JSON.generate("locale": 'en-us')
        )
        return profil.body
    end


    ### VERIFICATION ##########################

     def identifySpeaker
      audiofile = File.open("app/assets/audio/test.wav") ##File.open("app/assets/audio/#{audioFileLoaded}")
      speaker = Excon.post('https://eastus.api.cognitive.microsoft.com/speaker/verification/v2.0/text-independent/profiles/identifySingleSpeaker?profileIds={profileIds}',
      headers:{
          'Content-Type' => 'audio/wave',
          'Ocp-Apim-Subscription-Key' => "#{ENV['AZURE_KEY']}"
      },
      body: audiofile,
    )
    return speaker.body
  end

  def createEnroll
      audiofile = File.open("app/assets/audio/test.wav") ##File.open("app/assets/audio/#{audioFileLoaded}")
      enroll = Excon.post('https://eastus.api.cognitive.microsoft.com/speaker/verification/v2.0/text-independent/profiles/{profileId}/enrollments',
      headers: {
          'Content-Type' => 'audio/wave',
          'Ocp-Apim-Subscription-Key' => "#{ENV['AZURE_KEY']}"
      },
      body: audiofile
   )
    return enroll.body
  end

  def createProfile
    connection =
      Excon.post(
        'https://eastus.api.cognitive.microsoft.com/speaker/verification/v2.0/text-independent/profiles',
        headers: {
          'Content-Type' => 'application/json',
          'Ocp-Apim-Subscription-Key' => "#{ENV['AZURE_KEY']}"
        },
        body: JSON.generate("locale": 'en-us')
      )
    return connection.body
  end

  def getProfile
    profil =
      Excon.get(
        'https://eastus.api.cognitive.microsoft.com/speaker/verification/v2.0/text-independent/profiles/"dc53bdab-feef-4310-aefd-b5f8581ddd6e",',
        headers: {
          'Content-Type' => 'application/json',
          'Ocp-Apim-Subscription-Key' => "#{ENV['AZURE_KEY']}"
        },
        body: JSON.generate("locale": 'en-us')
      )
      return profil.body
  end