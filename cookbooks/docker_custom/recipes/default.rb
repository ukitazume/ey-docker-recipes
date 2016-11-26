install_docker = node['dna']['instance_role'] == "util" && node['docker_custom']['docker_instances'].include?(node['dna']['name'])

if install_docker
  include_recipe "docker_custom::install"
  include_recipe 'docker_custom::registry'
  
  docker_image "ukitazume/hello-node" do
    tag "latest"
    action :pull
  end

  docker_container "hello-node" do
    repo "ukitazume/hello-node"
    tag "latest"
    port "8081:8080"
    restart_policy "always"
    action :run
  end
end

