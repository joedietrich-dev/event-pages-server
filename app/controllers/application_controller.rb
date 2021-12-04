class ApplicationController < Sinatra::Base
  set :default_content_type, "application/json"

  get "/" do
    { test: "The quick brown fox jumps over the lazy dog"}.to_json
  end

  get "/events" do
    Event.all.to_json(include: :hosts)
  end
end