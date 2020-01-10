require './config/environment'

use Rack::MethodOverride
use UsersController
use PerksController
use CharacterController
use BuildController
run ApplicationController
