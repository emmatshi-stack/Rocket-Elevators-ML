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
    end
    def get_profile
        puts "*****************************ghghjfjdkdkng*******************************************"
        uri = URI('https://eastus.api.cognitive.microsoft.com/speaker/identification/v2.0/text-independent/profiles')
            uri.query = URI.encode_www_form({})
            
            request = Net::HTTP::Get.new(uri.request_uri)

            request['Ocp-Apim-Subscription-Key'] = '3c43bca9ad884fe39518a5cf3925e707'
            request.body = "{body}"

            response = Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https') do |http|
                http.request(request)
            end


            p JSON.parse(response.body)
            
            respond_to do |format|
                format.json { render json:  response.body }
            end
            

    end


    def enrollment
        
    end
    
   

    def identification
        puts "******************************IDENTIFY******************************************"
        puts "************************************************************************"
        require 'net/http'

        uri = URI('https://eastus.api.cognitive.microsoft.com/speaker/identification/v2.0/text-independent/profiles/identifySingleSpeaker?profileIds={profileIds}')
        uri.query = URI.encode_www_form({
            # Request parameters
            'shortAudio' => '{boolean}'
        })

        request = Net::HTTP::Post.new(uri.request_uri)
        # Request headers
        request['Content-Type'] = 'AUDIO/WAVE'
        # Request headers
        request['Ocp-Apim-Subscription-Key'] = '3c43bca9ad884fe39518a5cf3925e707'
        # Request body
        request.body = "{body}"

        response = Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https') do |http|
            http.request(request)
        end

        puts response.body
        
    end  

    def speechToText
        # convert file into binary
        puts "************************************************************************"

        
    end

    def profile
        uri = URI('https://eastus.api.cognitive.microsoft.com/speaker/identification/v2.0/text-independent/profiles')
        uri.query = URI.encode_www_form({})
        result = Net::HTTP.new(uri.host, uri.port)
        request = Net::HTTP::Post.new(uri)
        request['Content-Type'] = 'application/json'
        request['Ocp-Apim-Subscription-Key'] = '3c43bca9ad884fe39518a5cf3925e707'
        request.body = '{ "locale":"en-us", }'
        response = result.request(request)
        pp response.body
        respond_to do |format|
            format.json { render json:  response.body }
        end
    puts "IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII"
    end
    

   
end
