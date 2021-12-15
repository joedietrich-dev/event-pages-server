class SponsorController < Sinatra::Base
  set :default_content_type, "application/json"
  
  get "/sponsors" do
    Sponsor.all.to_json
  end

  post "/sponsors" do
    sponsor = Sponsor.create(name: params[:name], logo_src: params[:logo_src])
    sponsor.to_json
  end

  get "/sponsors/:id" do
    Sponsor.find(params[:id]).to_json(
      include: [
        event_sponsors: {
          only: [:id, :order],
          include: [
            event_sponsor_level: {only: [:id, :name, :rank]},
            event: {only: [:id, :title]}
          ]
        },
        panels: {only: [:id, :title], include: [event: {only: [:id, :title]}]}
      ])
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