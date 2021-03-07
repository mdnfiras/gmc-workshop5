provisionPath = "initscripts/init.sh"
jenkinsDockerfile = "jenkins_docker/Dockerfile"
jenkinsScript = "initscripts/jenkins.sh"

nodes = [
	{:hostname => "gmc5", :ip => "192.168.20.5", :cpus => 2, :mem => 1024, :provisionScript => provisionPath}
]


Vagrant.configure(2) do |config|
	nodes.each do |node|
		config.vm.define node[:hostname] do |vmachine|
			vmachine.vm.box_download_insecure = true
			vmachine.vm.box = "peru/ubuntu-18.04-server-amd64"
			vmachine.vm.box_check_update = false
			vmachine.vm.hostname = node[:hostname]
			vmachine.vm.network "private_network", ip: node[:ip]
            vmachine.vm.network "forwarded_port", guest: 8080, host: 8085
			vmachine.vm.provider :virtualbox do |domain|
				domain.memory = node[:mem]
				domain.cpus = node[:cpus]
			end
			vmachine.vm.provision :shell, path: node[:provisionScript]
            vmachine.vm.provision "file", source: jenkinsDockerfile, destination: jenkinsDockerfile
			vmachine.vm.provision :shell, path: jenkinsScript
		end
	end
end