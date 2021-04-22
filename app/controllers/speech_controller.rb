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

    def speech
        @profile = ProfileId.all
        puts @profile
    end
    #speech();

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
        puts "======="
        puts profil.body
        @profilTest = profil.body
        puts "======="
        
        return profil.body
        parsed = JSON.parse(profil.body)
            return parsed['profiles']
        rescue Excon::Error => e
            puts "Error: #{e}"

    end


    def enrollment
      user_name = params[:user_name]
      
        connection =
        Excon.post(
          'https://eastus.api.cognitive.microsoft.com/speaker/identification/v2.0/text-independent/profiles',
          headers: {
            'Content-Type' => 'application/json',
            'Ocp-Apim-Subscription-Key' => "3c43bca9ad884fe39518a5cf3925e707"
          },
          body: JSON.generate("locale": 'en-us')
        )
        puts"==============================="
        puts params
        parsed = JSON.parse(connection.body)
        puts user_name
      @profile = ProfileId.new
      @profile.user_name = user_name
      @profile.profile_id = parsed["profileId"]
      @profile.save
      create_profile();
      
    end

     def create_profile
      puts "create profile"
      puts "-----------------------------"
      puts params
      puts "-----------------------------"
      file = params[:enrollment_file]
      puts file

      enroll = Excon.post("https://eastus.api.cognitive.microsoft.com/speaker/identification/v2.0/text-independent/profiles/#{@profile.profile_id}/enrollments",
      headers: {
          'Content-Type' => 'audio/*',
          'Ocp-Apim-Subscription-Key' => "3c43bca9ad884fe39518a5cf3925e707"

      },
      body: file,
      )
      
     puts enroll.body
      #puts "==============enroll"
      return enroll.body
    end
    
   

    def identification
      puts "-----------------------------"
      puts params
      puts "-----------------------------"
        file = params[:identification_file]
        puts file
        profileid = params[:profile_id]
        puts "================================"
        puts profileid
        
        speaker = Excon.post("https://eastus.api.cognitive.microsoft.com/speaker/identification/v2.0/text-independent/profiles/identifySingleSpeaker?profileIds=" + profileid.to_s,
            headers:{
                'Content-Type' => 'audio/wave',
                'Ocp-Apim-Subscription-Key' => "3c43bca9ad884fe39518a5cf3925e707"
            },
            body: file,
          )
          puts speaker.body
          puts @speech
          
          return JSON.parse(speaker.body)
          
    end  


   

    def speech_params
        params.require(:identification).permit(:file)
    end
    

   
end