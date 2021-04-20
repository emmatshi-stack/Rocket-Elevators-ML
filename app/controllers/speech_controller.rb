class SpeechController < ApplicationController
    # before_action :require_login
    # Restricting action only to log in users with authorisation
    
    # def require_login
    #     if !current_user
    #       flash[:error] = "You must be logged in to access this section"
    #       redirect_to main_app.root_path # halts request cycle
    #     end
    #   end

    def index
    end

    def new
    end

    def create_enroll
      
    end

    def create_profil
      @profile = ProfileId.new
    end

    def get_profil
    
    end

    
end




