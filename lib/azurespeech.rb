
  ###IDENTIFICATION
    def identifySpeaker
        connection = Excon.post('https://eastus.api.cognitive.microsoft.com/speaker/identification/v2.0/text-independent/profiles/identifySingleSpeaker?profileIds={profileIds}',
        headers:{
          'Content-Type' => 'application/json',
            'Ocp-Apim-Subscription-Key' => "#{ENV['AZURE_KEY']}"
        },
        body: audio/wave
      )
    end

    def createEnroll
        connection = Excon.post('https://eastus.api.cognitive.microsoft.com/speaker/identification/v2.0/text-independent/profiles/{profileId}/enrollments',
        headers: {
            'Content-Type' => 'application/json',
            'Ocp-Apim-Subscription-Key' => "#{ENV['AZURE_KEY']}"
        },
        body: JSON.generate("locale": 'en-us')
     )
      return connection.body
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
        response = connection['profileId']##??????????
      return connection.body
    end

    def getProfile
      connection =
        Excon.get(
          'https://eastus.api.cognitive.microsoft.com/speaker/identification/v2.0/text-independent/profiles/"dc53bdab-feef-4310-aefd-b5f8581ddd6e",',
          headers: {
            'Content-Type' => 'application/json',
            'Ocp-Apim-Subscription-Key' => "#{ENV['AZURE_KEY']}"
          },
          body: JSON.generate("locale": 'en-us')
        )
        return connection.body['profile']####?????
    end


    ### VERIFICATION ##########################

    def createEnroll(file_name, profile_id)
        file = File.open(file path)
        endpoint =
          "https://eastus.api.cognitive.microsoft.com/speaker/verification/v2.0/text-independent/profiles/#{
            profile_id
          }/enrollments"
    
        begin
          connection =
            Excon.post(
              endpoint,
              debug_request: true,
              debug_connection: true,
              headers: {
                'Content-Type' => 'audio/wave',
                'Ocp-Apim-Subscription-Key' => "#{ENV['AZURE_KEY']}"
              },
              body: file,
              instrumentor: ActiveSupport::Notifications
            )
          return connection.body
        end
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
      connection =
        Excon.get(
          'https://eastus.api.cognitive.microsoft.com/speaker/verification/v2.0/text-independent/profiles',
          headers: {
            'Content-Type' => 'application/json',
            'Ocp-Apim-Subscription-Key' => "#{ENV['AZURE_KEY']}"
          },
          body: JSON.generate("locale": 'en-us')
        )
      response = JSON.parse(connection.body)
      return response[0]
    end