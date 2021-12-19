class SponsorController < Sinatra::Base
  set :default_content_type, "application/json"
  
  get "/sponsors" do
    Sponsor.all.to_json
  end
    
  get "/event_sponsor_levels" do
    EventSponsorLevel.all.to_json
  end

  post "/sponsors" do
    sponsor = Sponsor.create(name: params[:name], logo_src: params[:logo_src])
    sponsor.to_json
  end

  get "/sponsors/:id" do
    sponsor = Sponsor.includes(:event_sponsors, :event_sponsor_levels, :events, panels: [:event]).find(params[:id])
    res = {
      id: sponsor.id,
      name: sponsor.name,
      logo_src: sponsor.logo_src,
      sponsored_events: sponsor.event_sponsors.map do |link|
        {
          id: link.event.id,
          title: link.event.title,
          event_sponsor_level: { 
            id: link.event_sponsor_level.id, 
            rank: link.event_sponsor_level.rank, 
            name: link.event_sponsor_level.name },
          order: link.order,
          event_sponsor_id: link.id
        }
      end,
      panels: sponsor.panels.map do |panel|
        {
          id: panel.id,
          title: panel.title,
          event: panel.event.title,
          event_id: panel.event.id,
        }
      end,
      created_at: sponsor.created_at,
      updated_at: sponsor.updated_at
    }
    res.to_json
  end

  patch "/sponsors/:id" do
    sponsor = Sponsor.find(params[:id])
    sponsor.update(
      name: params[:name],
      logo_src: params[:logo_src]
    )
    sponsor.to_json
  end

  delete "/sponsors/:id" do
    sponsor = Sponsor.find(params[:id])
    sponsor.destroy
  end
end