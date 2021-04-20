require 'net/http'
require 'json'

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
   

    def identification
        puts "######################################################################"
    end  

    def speechToText
        puts "************************************************************************"
    end
    def profile
        puts "IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII"
    end

   
end
