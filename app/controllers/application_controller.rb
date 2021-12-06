class ApplicationController < Sinatra::Base
  set :default_content_type, "application/json"

  get "/" do
    { test: "The quick brown fox jumps over the lazy dog"}.to_json
  end

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

  get "/honorees" do
    Honoree.all.to_json
  end

  get "/honorees/:id" do
    Honoree.find(params[:id]).to_json(
      include: [event: {only: [:id, :title]}],
      except: :event_id
    )
  end

  get "/hosts" do
    Host.all.to_json
  end

  get "/hosts/:id" do
    Host.find(params[:id]).to_json(
      include: [event: {only: [:id, :title]}],
      except: :event_id
    )
  end

  get "/panelists" do
    Panelist.all.to_json
  end

  get "/panelists/:id" do
    panelist = Panelist.includes(:panel_panelists, panels: [:event]).find(params[:id])
    res = {
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

  get "/panels" do
    Panel.all.to_json
  end

  get "/panels/:id" do
    Panel.find(params[:id]).to_json(
      include: [
        event: {only: [:id, :title]},
        panelists: {only: [:id, :name]}
      ],
      except: :event_id
    )
  end

end