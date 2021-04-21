require 'json'
require 'httparty'
require 'net/http'
require 'net/http'

uri = URI('https://westus.api.cognitive.microsoft.com/spid/v1.0/identificationProfiles/{identificationProfileId}/enroll')
uri.query = URI.encode_www_form({
    # Request parameters
    'shortAudio' => '{boolean}'
})

request = Net::HTTP::Post.new(uri.request_uri)
# Request headers
request['Content-Type'] = 'multipart/form-data'
# Request headers
request['Ocp-Apim-Subscription-Key'] = '{subscription key}'
# Request body
request.body = "{body}"

response = Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https') do |http|
    http.request(request)
end

puts response.body

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

    def enrollment
        
        uri = URI('https://westus.api.cognitive.microsoft.com/spid/v1.0/identificationProfiles/{identificationProfileId}/enroll')
        uri.query = URI.encode_www_form({
            # Request parameters
            'shortAudio' => '{boolean}'
        })

        request = Net::HTTP::Post.new(uri.request_uri)
        # Request headers
        request['Content-Type'] = 'multipart/form-data'
        # Request headers
        request['Ocp-Apim-Subscription-Key'] = '{subscription key}'
        # Request body
        request.body = "{body}"

        response = Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https') do |http|
            http.request(request)
        end

        puts response.body
    end
    
   

    def identification
        # convert file into binary
        puts "######################################################################"
        response = HTTParty.get("https://ipinfo.io/161.185.160.93/geo")
        case response.code
        # if the request is successfull
        when 200
            if response['region'].is_a? String and response['country'].is_a? String and response['city'].is_a? String
                html_body="<div style='margin:0 auto; width:80%'><p>"+response["city"]+"</p>
                                <p>"+response['region']+response["country"]+"</p>
                                </div>"
            else
                html_body ="<div> there is a problem with the API try again later</div>"
    
            end
          puts "All good!"
        # in the case of 404 error
        when 404
          puts "O noes not found!"
          html_body ="<div> there is a problem with the API try again later</div>"
        # in the case of 500...600 error
        when 500...600
          puts "ZOMG ERROR #{response.code}"
          html_body ="<div> there is a problem with the API try again later</div>"
        end
        puts response
    end  

    def speechToText
        # convert file into binary
        puts "************************************************************************"

        url .....................
        recupere 

        repsponse ............... view 
    end

    def profile
        puts "IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII"
    end

   
end
