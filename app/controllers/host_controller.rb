class HostController < Sinatra::Base
  set :default_content_type, "application/json"

  get "/hosts" do
    Host.all.to_json
  end

  post "/hosts" do
    host = Host.create(name: params[:name], bio: params[:bio], headshot_src: params[:headshot_src])
    host.to_json
  end

  get "/hosts/:id" do
    Host.find(params[:id]).to_json(
      include: [event: {only: [:id, :title]}],
      except: :event_id
    )
  end

  patch "/hosts/:id" do
    host = Host.find(params[:id])
    host.update(name: params[:name], bio: params[:bio], headshot_src: params[:headshot_src])
    host.to_json
  end

  delete "/hosts/:id" do
    host = Host.find(params[:id])
    host.destroy
  end
end