class InterventionsController < ApplicationController
    #before_action :require_login
    # Restricting action only to log in users with authorisation
    
    def require_login
        if !current_user
          flash[:error] = "You must be logged in to access this section"
          redirect_to main_app.root_path # halts request cycle
        end
      end
    # definning a new interventions
    def interventions
        @interventions = Intervention.new
        puts @interventions
        puts params
        
        
    end
    # selecting building with belonging to the customer id
    def getbuildings
        
        puts params
        custid = params["custormerid"]

        var s = "select * from customer where cusotmerid = "+custid
        buildings = Building.where(:customer_id => custid)
        puts buildings.inspect
        respond_to do |format|
         format.json { render json: buildings }
        end

    end
    # selecting batteries with belonging to the building selected
    def getbatteries
        puts params
        buildid = params["buildingid"]

        batteries = Battery.where(:building_id => buildid)

        puts batteries.inspect
        puts "#################################################"
        
        respond_to do |format|
            format.json { render json: batteries }
        end
    end
    # selecting column with belonging to the battery selected
    def getcolumns
        puts params
        colid = params["batteryid"]

        columns = Column.where(:battery_id => colid)

        puts columns.inspect
        
        @x = columns
        respond_to do |format|
            format.json { render json: columns }
        end
    end
    # selecting elevators with belonging to the column selected
    def getelevators
        puts params
        elid = params["columnid"]

        elevators = Elevator.where(:column_id => elid)

        puts elevators.inspect
        
        respond_to do |format|
            format.json { render json: elevators }
        end
    end

    # saving the informations coming from the intervention form
    def save
        intervention =  Intervention.new
        puts params

        customer = params["intervention"]["customer_id"]
        building = params["intervention"]["building_id"]
        battery = params["intervention"]["battery_id"]
        column = params["intervention"]["column_id"]
        elevator = params["intervention"]["elevator_id"]
        employee = params["intervention"]["employee_id"]
        description = params["intervention"]["reports"]

        p "user information: "
        p current_user

        intervention.author = current_user.id
        intervention.result = "Incomplete"
        intervention.reports = description
        intervention.status = "Pending"
        intervention.customer_id = customer
        intervention.building_id = building
        intervention.employee_id = employee
        if battery != "-1"
            intervention.battery_id = battery

        end

        
        
        #restricting the save of column data when battery selected
        if column != "-1"
            intervention.column_id = column
            intervention.battery_id = nil
            

            
        end 
        #restricting the save of elevators data when column and battery selected selected
        if elevator != "-1"
            intervention.elevator_id = elevator
            intervention.column_id = nil
            intervention.battery_id = nil

        end 

        
        
        
        customer_int = Customer.where(:id => intervention.customer_id)
        employee_int = Employee.where(:id => intervention.employee_id)
        
            


        p "#####################################start#############################################"
        p customer_int
        p "#########################################middle############################################"

        p employee_int
        p "#########################################end############################################"



        puts intervention.inspect
        #intervention.save!
        if intervention.save
            # fact_contacts()
            #sendMail()
            #dropbox()

            #call to send a zendesk ticket
            client = ZendeskAPI::Client.new do |config|
                config.url = ENV["ZENDESK_URL"]
                config.username = ENV["ZENDESK_EMAIL"]
                config.token = ENV["ZENDESK_TOKEN"]
            end
    
            ZendeskAPI::Ticket.create!(client,
            :subject => "#{intervention.id} from #{intervention.id}",
            :comment => {
                :value => "An intervention form has been submitted by the employee having the following information: 
                The Requester: #{intervention.author} ftps://waws-prod-blu-207.ftp.azurewebsites.windows.net/site/wwwroot 
                Building ID: #{intervention.building_id}
                The Battery ID: #{intervention.battery_id}
                The Column ID : #{intervention.column_id}
                Elevator ID if specified: #{intervention.elevator_id}
                Description of the request for intervention: #{intervention.reports}

                Thank you Rocket Elevator is there for your vertical transportation need.
    
                
    
                Attached Message: 
    
                The Contact uploaded an attachment"
            },
            :priority => "normal",
            :type => "question"
            )

            #redirecting to success page after saving the form
            redirect_to success_url
      
        end
       
        
    end

    
end