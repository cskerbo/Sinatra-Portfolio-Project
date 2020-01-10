require './config/environment'
require_all 'app'

run Sinatra::Application
use Rack::MethodOverride
use UsersController
use PerksController
use CharacterController
use BuildController
run ApplicationController
