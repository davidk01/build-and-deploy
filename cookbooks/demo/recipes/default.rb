#
# Cookbook Name:: demo
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

bash 'update apt' do
  code 'apt-get update'
  not_if { File.exists? "/vagrant/no_update" }
end

['vim', 'build-essential', 'libxml2-dev', 
  'libxslt1-dev', 'ruby1.9.3'].each do |p|
  apt_package p
end

['sinatra', 'showoff', 'pdfkit', 'fpm', 'chef', 'librarian-chef'].each do |g|
  bash "installing #{g}" do
    code "sudo -u vagrant -H -s sudo gem install #{g} --no-ri --no-rdoc"
  end
end

ruby_block 'fix GLI and bind nonsense' do
  block do
    # fix GLI nonsense
    showoff = File.read("/var/lib/gems/1.9.1/gems/showoff-0.7.0/bin/showoff")
    showoff.gsub!(/^include GLI\n/, "include GLI::App\n")
    showoff.gsub!("GLI.run", "run")
    open("/var/lib/gems/1.9.1/gems/showoff-0.7.0/bin/showoff", "w") do |f|
      f.puts showoff
    end
    # fix bind nonsense
    showoff_lib = File.read("/var/lib/gems/1.9.1/gems/showoff-0.7.0/lib/showoff.rb")
    showoff_lib.gsub!(/set :verbose, false/, "set(:verbose, true); set(:bind, '0.0.0.0')")
    open("/var/lib/gems/1.9.1/gems/showoff-0.7.0/lib/showoff.rb", "w") do |f|
      f.puts showoff_lib
    end
  end
end
