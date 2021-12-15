class PanelistController < Sinatra::Base
  set :default_content_type, "application/json"

  get "/panelists" do
    Panelist.all.to_json
  end

  post "/panelists" do
    panelist = Panelist.create(
      name: params[:name],
      title: params[:title],
      company: params[:company],
      bio: params[:bio],
      headshot_src: params[:headshot_src]
    )
    panelist.to_json
  end

  get "/panelists/:id" do
    panelist = Panelist.includes(:panel_panelists, panels: [:event]).find(params[:id])
    res = {
      id: panelist.id,
      name: panelist.name,
      title: panelist.title,
      company: panelist.company,
      bio: panelist.bio,
      headshot_src: panelist.headshot_src,
      panels: panelist.panel_panelists.map do | link | 
        {
          id: link.panel.id,
          title: link.panel.title,
          event: link.panel.event.title,
          event_id: link.panel.event.id,
          is_moderator: link.is_moderator
        }
      end,
      created_at: panelist.created_at,
      updated_at: panelist.updated_at
     }
    res.to_json
  end

  patch "/panelists/:id" do
    panelist = Panelist.find(params[:id])
    panelist.update(
      name: params[:name],
      title: params[:title],
      company: params[:company],
      bio: params[:bio],
      headshot_src: params[:headshot_src]
    )
    panelist.to_json
  end

  delete "/panelists/:id" do
    panelist = Panelist.find(params[:id])
    panelist.destroy
  end
end