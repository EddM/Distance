require 'rubygems'
require 'bundler/setup'
require 'releasy'

Releasy::Project.new do
  name "Untitled"
  version "1.0"
  verbose

  executable "run.rb"
  files ["run.rb", "lib/**/*.rb", "res/**/*.*"]
  add_link "http://github.com/EddM", "GitHub"
  exclude_encoding

  add_build :osx_app do
    url "com.eddmorgan.ld48"
    wrapper "etc/gosu-mac-wrapper-0.7.47.tar.gz"
    icon "res/Icon.icns"
    add_package :tar_gz
  end
  
  add_build :windows_standalone do
    executable_type :windows
  end
end

task :icons do
  `iconutil -c icns res/Icon.iconset`
end
