# Load the rails application
require File.expand_path('../application', __FILE__)
#require 'mini_magick'
# Initialize the rails application
Mime::Type.register 'image/jpeg', :jpg
Baka::Application.initialize!
