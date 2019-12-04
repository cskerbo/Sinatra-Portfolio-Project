require './config/environment'

use Rack::MethodOverride
use UsersController
use CharacterController
use PerksController
run ApplicationController
