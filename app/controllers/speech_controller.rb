require 'json'
require 'httparty'
require 'net/http'
require 'net/http'


class SpeechController < ApplicationController
    before_action :require_login
    before_action :speech
    # Restricting action only to log in users with authorisation
    
    def require_login
        if !current_user
          flash[:error] = "You must be logged in to access this section"
          redirect_to main_app.root_path # halts request cycle
        end
        
    end
####################################### GET PROFILE FROM DATABASE ###################
    def speech
      
        @profile = ProfileId.all
    end
####################################### GET PROFILE FROM AZURE SERVICES ###################
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
        return profil.body
        parsed = JSON.parse(profil.body)
            return parsed['profiles']
        rescue Excon::Error => e
            puts "Error: #{e}"

    end
####################################### CREATE AND ENROLL NEW PROFILE ###################
    def enrollment
      
      connection =
        Excon.post(
          'https://eastus.api.cognitive.microsoft.com/speaker/identification/v2.0/text-independent/profiles',
          headers: {
            'Content-Type' => 'application/json',
            'Ocp-Apim-Subscription-Key' => "3c43bca9ad884fe39518a5cf3925e707"
          },
          body: JSON.generate("locale": 'en-us')
        )
        @parsed = JSON.parse(connection.body)
      create_DB_profile();
      create_profile();
    end
    ####################################### CREATE PROFILE IN DATABASE ###################
    def create_DB_profile
      
      @profile = ProfileId.new
      @profile.user_name = params[:user_name]
      @profile.profile_id = @parsed["profileId"]
      @profile.save
    end
####################################### ENROLL PROFILE ###################
     def create_profile
      
      file = params[:enrollment_file]

      enroll = Excon.post("https://eastus.api.cognitive.microsoft.com/speaker/identification/v2.0/text-independent/profiles/#{@profile.profile_id}/enrollments",
      headers: {
          'Content-Type' => 'audio/*',
          'Ocp-Apim-Subscription-Key' => "3c43bca9ad884fe39518a5cf3925e707"

      },
      body: file,
      )
      
      #puts enroll.body
      #puts "==============enroll"
      return enroll.body
    end
####################################### IDENTIFY PROFILE FROM AUDIO FILE ###################
    def identification
      
      file = params[:identification_file]
        # puts file
        profileid = params[:profile_id]
        # puts "================================"
        # puts profileid
          
        speaker = Excon.post("https://eastus.api.cognitive.microsoft.com/speaker/identification/v2.0/text-independent/profiles/identifySingleSpeaker?profileIds=" + profileid.to_s,
          headers:{
            'Content-Type' => 'audio/wave',
            'Ocp-Apim-Subscription-Key' => "3c43bca9ad884fe39518a5cf3925e707"
          },
            body: file,
          )
        puts speaker.body
        return JSON.parse(speaker.body)
    end  

   
end