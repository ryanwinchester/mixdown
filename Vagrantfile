Vagrant.configure("2") do |config|
  config.vm.box = "pgrunwald/elixir-phoenix-ubuntu-trusty64"

  config.vm.network "forwarded_port", guest: 4000, host: 4000

  config.vm.synced_folder ".", "/vagrant_data"

  config.vm.provision "shell", inline: <<-SHELL
    cd /vagrant_data
    mix deps.get
    npm install
    node node_modules/brunch/bin/brunch build
    mix ecto.create
    mix ecto.migrate
  SHELL

  config.vm.provision :shell, run: "always", inline: <<-SHELL
    cd /vagrant_data
    elixir --detached -S mix phoenix.server
  SHELL
end
