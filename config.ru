require_relative "./config/environment"

use Rack::Cors do
  allow do
    origins '*'
    resource '*', headers: :any, methods: [:get, :post, :delete, :put, :patch, :options, :head]
  end
end

use Rack::JSONBodyParser

use EventController
use HonoreeController
use HostController
use PanelController
use PanelistController
use SponsorController
run ApplicationController