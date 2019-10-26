#
# This script installs and configures WSL to work with Docker Toolbox for Windows.
# 1. Install WSL (check out [bowinstaller](https://github.com/xezpeleta/bowinstaller) for programmatic installation.
# 2. Run the contents of this script in Bash. (copy and paste works fine, no need to save)
#
sudo -sEH << 'EOM'
# Install the docker client and docker-compose
apt-get update && apt-get install -y curl ca-certificates
curl -sSL https://get.docker.com/ | sh
curl -L "https://github.com/docker/compose/releases/download/1.11.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
# Add the current user to the docker group.
usermod -aG docker $(id -un)
# Symlink /c/ to /mnt/c/ as Docker Toolbox is expects /c/ path mappings.
[[ ! -e /c/ ]] && ln -s /mnt/c /
EOM

#Set docker-machine to run on terminal start.
cat >> ~/.bashrc << 'EOM'
   # Start the docker machine
  export VBOX_MSI_INSTALL_PATH='/c/Program Files/Oracle/VirtualBox/'
  pushd '/c/Program Files/Docker Toolbox/' > /dev/null
  ./start.sh exit
  # Get env variables from docker-machine, convert paths, ignore comments, and strip double quotes. 
  $(./docker-machine.exe env --shell bash | sed 's/C:/\/c/' | sed 's/\\/\//g' | sed 's:#.*$::g' | sed 's/"//g' )
  popd > /dev/null
  # Change /mnt/c/ to /c/ in current working directory path
  cd $(pwd | sed 's/\/mnt\/c\//\/c\//')
EOM
