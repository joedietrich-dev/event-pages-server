class EventController < Sinatra::Base
  set :default_content_type, "application/json"
  
  get "/events" do
    Event.all.to_json
  end

  get "/events/:id" do
    Event.find(params[:id]).to_json(
      include: [
        panels: {
          except: [:created_at, :updated_at, :event_id],
          include: [
            panelists: {except: [:created_at, :updated_at]},
            sponsors: {except: [:created_at, :updated_at]},
          ]
        }, 
        hosts: {except: [:created_at, :updated_at, :event_id]}, 
        honorees: {except: [:created_at, :updated_at, :event_id]}, 
        event_sponsors: { only: [:order],
                          include: [
                            sponsor: {except: [:created_at, :updated_at]},
                            event_sponsor_level: {except: [:created_at, :updated_at]}]
                        }
      ])
  end

end