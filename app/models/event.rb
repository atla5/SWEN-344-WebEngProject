class Event < ActiveRecord::Base
    belongs_to :user
    attr_accessible :name, :start_time, :location
end

def write_json
    Event.all.each do |event|
            @eventJson = {
            "id" => event.id,
            "name" => event.name,
            "start_time" => event.start_time,
            "location" => event.location,
            }
    end
    File_open("public/event.json","w") do |f|
        f.write(@eventJson.to_json)
    end
end