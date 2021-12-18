class EventController < Sinatra::Base
  set :default_content_type, "application/json"
  
  get "/events" do
    Event.all.to_json
  end
  
  post "/events" do
    event.create(
      title: params[:title],
      description: params[:description],
      short_description: params[:short_description],
      location: params[:location],
      hero_src: params[:hero_src],
      register_link: params[:register_link],
      view_link: params[:view_link],
      date: params[:date],
    )
  end

  get "/events/:id" do
    Event.includes(:sponsors, :event_sponsor_levels).find(params[:id]).to_json(
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
        event_sponsors: { only: [:id, :order],
                          include: [
                            sponsor: {except: [:created_at, :updated_at]},
                            event_sponsor_level: {except: [:created_at, :updated_at]}]
                        }
      ])
  end

  delete "/events/:id" do
    event = Event.find(params[:id])
    event.destroy
  end

  patch "/events/:id" do
    event = Event.find(params[:id])
    event.update(
      title: params[:title],
      description: params[:description],
      short_description: params[:short_description],
      location: params[:location],
      hero_src: params[:hero_src],
      register_link: params[:register_link],
      view_link: params[:view_link],
      date: params[:date],
    )
  end

  # Event Host Paths
  post "/events/:id/hosts/:host_id" do
    host = Host.find(params[:host_id])
    host.update(event_id: params[:id])
    host.to_json
  end
  
  delete "/events/:id/hosts/:host_id" do
    host = Host.find(params[:host_id])
    host.update(event_id: nil)
    host.to_json
  end

  # Event Honoree Paths
  post "/events/:id/honorees/:honoree_id" do
    honoree = Honoree.find(params[:honoree_id])
    honoree.update(event_id: params[:id])
    honoree.to_json
  end
  
  delete "/events/:id/honorees/:honoree_id" do
    honoree = Honoree.find(params[:honoree_id])
    honoree.update(event_id: nil)
    honoree.to_json
  end

  # Event Panel Paths
  post "/events/:id/panels/:panel_id" do
    panel = Panel.find(params[:panel_id])
    panel.update(event_id: params[:id])
    panel.to_json
  end
  
  delete "/events/:id/panels/:panel_id" do
    panel = Panel.find(params[:panel_id])
    panel.update(event_id: nil)
    panel.to_json
  end

  # Event Sponsor Paths
  post "/events/:id/sponsors/:sponsor_id" do
    event_sponsor = EventSponsor.create(
      event_id: params[:id],
      sponsor_id: params[:sponsor_id],
      event_sponsor_level_id: params[:event_sponsor_level_id]
    )
    event_sponsor.to_json(only: [:id, :order],
                          include: [
                            sponsor: {except: [:created_at, :updated_at]},
                            event_sponsor_level: {except: [:created_at, :updated_at]}])
  end
  
  patch "/events/:id/event_sponsors/:event_sponsor_id" do
    event_sponsor = EventSponsor.find(params[:event_sponsor_id])
    event_sponsor.update(event_sponsor_level_id: params[:event_sponsor_level_id])
    event_sponsor.to_json(only: [:id, :order],
                          include: [
                            sponsor: {except: [:created_at, :updated_at]},
                            event_sponsor_level: {except: [:created_at, :updated_at]}])
  end
  
  delete "/events/:id/event_sponsors/:event_sponsor_id" do
    event_sponsor = EventSponsor.find(params[:event_sponsor_id])
    event_sponsor.update(event_id: nil)
    event_sponsor.to_json
  end

end