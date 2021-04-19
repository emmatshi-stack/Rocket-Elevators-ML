require 'nokogiri'
require 'open-uri'
require 'json'
require 'net/http'
require 'httparty'

require 'ElevatorMedia/streamer'

describe Streamer do
    
    streamerOne = Streamer.new
    var = streamerOne.getContent()
    #checking if it returns a string
    it "returns a string" do
        expect(var).to be_a(String) 
    end
    #checking if the return start with a html div
    it "returns a html tag at the end " do
        expect(var).to end_with "</div>"  
    end
    #checking if the return end with a html div
    it "returns a html tag at the start " do
        expect(var).to start_with "<div"
    end



    

end