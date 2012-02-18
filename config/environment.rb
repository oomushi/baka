# Load the rails application
require File.expand_path('../application', __FILE__)
#require 'mini_magick'
# Initialize the rails application
Mime::Type.register 'image/jpeg', :jpg
Mime::Type.register 'image/gif',  :gif
Mime::Type.register 'image/png',  :png
Baka::Application.initialize!
