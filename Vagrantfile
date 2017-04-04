Vagrant.configure("2") do |config|
  config.vm.box = "pgrunwald/elixir-phoenix-ubuntu-trusty64"

  config.vm.network "forwarded_port", guest: 4000, host: 4000

  config.vm.synced_folder ".", "/vagrant_data"

  config.vm.provision "shell", inline: <<-SHELL
    cd /vagrant_data
    mix deps.get
    npm install
    mix ecto.create
    mix ecto.migrate
    elixir --detached -S mix phoenix.server
  SHELL
end
