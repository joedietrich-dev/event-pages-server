class HonoreeController < Sinatra::Base
  set :default_content_type, "application/json"
  
  get "/honorees" do
    Honoree.all.to_json
  end

  post "/honorees" do
    honoree = Honoree.create(
      name: params[:name], 
      descriptor: params[:descriptor], 
      honor: params[:honor], 
      bio: params[:bio],
      img_src: params[:img_src],
      event_id: params[:event_id] || nil
    )
    honoree.to_json
  end

  get "/honorees/:id" do
    Honoree.find(params[:id]).to_json(
      include: [event: {only: [:id, :title]}],
      except: :event_id
    )
  end

  patch "/honorees/:id" do
    honoree = Honoree.find(params[:id])
    honoree.update(
      name: params[:name], 
      descriptor: params[:descriptor], 
      honor: params[:honor], 
      bio: params[:bio],
      img_src: params[:img_src],
      event_id: params[:event_id] ||= honoree[:event_id]
    )
    honoree.to_json
  end

  delete "/honorees/:id" do
    honoree = Honoree.find(params[:id])
    honoree.destroy
  end
end