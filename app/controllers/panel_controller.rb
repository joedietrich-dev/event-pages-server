class PanelController < Sinatra::Base
  set :default_content_type, "application/json"
  
  get "/panels" do
    Panel.all.to_json
  end

  post "/panels" do
    panel = Panel.create(
      title: params[:title],
      description: params[:description],
      time: params[:time],
      event_id: params[:event_id])
    panel.to_json
  end

  get "/panels/:id" do
    panel = Panel.includes(:panel_panelists, :panelists, :sponsors, :event).find(params[:id])
    
    res = {
      id: panel.id,
      title: panel.title,
      description: panel.description,
      time: panel.time,
      event_id: panel.event.id,
      event_title: panel.event.title,
      panelists: panel.panel_panelists.map do |link|
        {
          id: link.panelist.id,
          name: link.panelist.name,
          title: link.panelist.title,
          company: link.panelist.company,
          headshot_src: link.panelist.headshot_src,
          is_moderator: link.is_moderator
        }
      end,
      sponsors: panel.sponsors.map do |sponsor|
        {
          id: sponsor.id,
          name: sponsor.name,
          logo_src: sponsor.logo_src
        }
      end,
      created_at: panel.created_at,
      updated_at: panel.updated_at
    }.to_json
  end

  patch "/panels/:id" do 
    panel = Panel.find(params[:id])
    panel.update(
      title: params[:title],
      description: params[:description],
      time: params[:time],
      event_id: params[:event_id]
    )
    panel.to_json
  end

  delete "/panels/:id" do
    panel = Panel.find(params[:id])
    panel.destroy
  end
end