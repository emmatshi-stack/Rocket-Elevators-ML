require 'json'
require 'httparty'
require 'net/http'
require 'net/http'


class SpeechController < ApplicationController
    before_action :require_login
    # before_action :speech
    
    
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
        @hello = 'HELLO'
        # @score = @identified['identifiedProfile']['score']
    end
####################################### GET PROFILE FROM AZURE SERVICES ###################
    def get_profile
      
        profil =
        HTTParty.get(
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
        rescue HTTParty::Error => e
            puts "Error: #{e}"

    end
####################################### CREATE AND ENROLL NEW PROFILE ###################
    def enrollment
     
      connection =
      HTTParty.post('https://eastus.api.cognitive.microsoft.com/speaker/identification/v2.0/text-independent/profiles',
        :body => JSON.generate("locale": 'en-us'),
        :headers => { 'Content-Type' => 'application/json',
                'Ocp-Apim-Subscription-Key' => "3c43bca9ad884fe39518a5cf3925e707" })
        @parsed = JSON.parse(connection.body)
      create_DB_profile();
      create_profile();
      redirect_to ('/speech')
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

      enroll = HTTParty.post("https://eastus.api.cognitive.microsoft.com/speaker/identification/v2.0/text-independent/profiles/#{@profile.profile_id}/enrollments",
      headers: {
          'Content-Type' => 'audio/*',
          'Ocp-Apim-Subscription-Key' => "3c43bca9ad884fe39518a5cf3925e707"

      },
      body: file,
      )
      
      return enroll.body
    end
####################################### IDENTIFY PROFILE FROM AUDIO FILE ###################
    def identification
        puts "-----------------------------"
        puts params
        puts "-----------------------------"
        # file = _file
          file = params[:identification_file]
          puts file
          profileid = params[:profile_id]
          # profileid = _profileid
          puts "================================"
          puts profileid
          

          speaker = HTTParty.post("https://eastus.api.cognitive.microsoft.com/speaker/identification/v2.0/text-independent/profiles/identifySingleSpeaker?profileIds=" + profileid.to_s,
              headers:{
                  'Content-Type' => 'audio/wave',
                  'Ocp-Apim-Subscription-Key' => "3c43bca9ad884fe39518a5cf3925e707"
              },
              body: file,
            )

            @identified = JSON.parse(speaker.body)
            @score = @identified['identifiedProfile']['score']
            @score1 = ("SCORE :" + @score.to_s)  
            puts @score1;
            redirect_to :speech, :notice =>"#{@score1}" 
            
    end
    def getScore
      puts "======================================================"
      puts @score1
      return @score1

    end
    helper_method :getScore
    
end