require './config/environment'


use Rack::MethodOverride
use NoteController
use UserController
run ApplicationController
