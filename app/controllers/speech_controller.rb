require 'json'
require 'httparty'
require 'net/http'
require 'net/http'


class SpeechController < ApplicationController
    before_action :require_login
    # Restricting action only to log in users with authorisation
    
    def require_login
        if !current_user
          flash[:error] = "You must be logged in to access this section"
          redirect_to main_app.root_path # halts request cycle
        end
      end

    def new
        @speech = Speech.new
        puts @speech
        # @speech = params["file_name"]
    end

    def get_profile
        profil =
        Excon.get(
          'https://eastus.api.cognitive.microsoft.com/speaker/identification/v2.0/text-independent/profiles',
          headers: {
            'Content-Type' => 'application/json',
            'Ocp-Apim-Subscription-Key' => "3c43bca9ad884fe39518a5cf3925e707"
          },
          body: JSON.generate("locale": 'en-us')
        )
        puts profil.body
        return profil.body
        parsed = JSON.parse(profil.body)
            return parsed['profiles']
        rescue Excon::Error => e
            puts "Error: #{e}"

    end


    def enrollment
        
    end
    
   

    def identification
        file = params[:uploadedFile]
        # audiofile = File.open(file)
        speaker = Excon.post('https://eastus.api.cognitive.microsoft.com/speaker/identification/v2.0/text-independent/profiles/identifySingleSpeaker?profileIds=dc53bdab-feef-4310-aefd-b5f8581ddd6e',
            headers:{
                'Content-Type' => 'audio/wave',
                'Ocp-Apim-Subscription-Key' => "3c43bca9ad884fe39518a5cf3925e707"
            },
            body: file,
          )
          puts speaker.body
          puts "=============="
          puts @speech
          return JSON.parse(speaker.body)
    end  


    def create_profile
        connection =s
        Excon.post(
          'https://eastus.api.cognitive.microsoft.com/speaker/identification/v2.0/text-independent/profiles',
          headers: {
            'Content-Type' => 'application/json',
            'Ocp-Apim-Subscription-Key' => "3c43bca9ad884fe39518a5cf3925e707"
          },
          body: JSON.generate("locale": 'en-us')
        )
      return connection.body
    end

    def speech_params
        params.require(:identification).permit(:file)
      end
    

   
end
