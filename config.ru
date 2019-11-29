require './config/environment'

use Rack::MethodOverride
use UsersController
use CharacterController
run ApplicationController
