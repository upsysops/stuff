Vagrant.configure("2") do |config|
  config.vm.box = "debian/buster64"
  config.vm.synced_folder '.', '/vagrant', disabled: true
  config.vm.hostname = "test.box"
  config.vm.network "forwarded_port", guest: 80, host: 8080,
    auto_correct: true
  config.vm.network "forwarded_port", guest: 9292, host: 9292,
    auto_correct: true
  config.vm.provider :virtualbox do |vb|
    vb.customize [
      "modifyvm", :id,
      "--cpuexecutioncap", "50",
      "--memory", "512",
    ]
  end
end
