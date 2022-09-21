#!/bin/bash



RED='\033[0;31m'
GREEN='\033[0;32m'
BLACK='\033[0m'


Magma_repo () {
echo -e ${GREEN}#########################################
echo -e ${GREEN}#    **MAGMA REPO**                 
echo -e ${GREEN}#########################################${BLACK}
}

Magma_clone () {
  DIR="$HOME/workspace-1/magma"
  if [ -d "$DIR" ]; then
    echo "Directory Exists ${DIR}"
  else
    mkdir workspace-1 && cd workspace-1
    echo "Give Repo Link"
    read Repo
    git clone $Repo
  fi

}


Magma_branch () {
  cd magma
  echo "Give the branch name"
  read Branch
  git checkout $Branch 
  export MAGMA_ROOT=$HOME/workspace-1/magma
}

Pre_requisite () {
echo -e ${GREEN}#########################################
echo -e ${GREEN}#    *Pre-requisites**
echo -e ${GREEN}#########################################${BLACK}
}

Install_pre_requisites () {
  sudo curl -O https://releases.hashicorp.com/vagrant/2.2.19/vagrant_2.2.19_x86_64.deb
  sudo apt update
  sudo apt install ./vagrant_2.2.19_x86_64.deb
  vagrant plugin install vagrant-vbguest vagrant-disksize vagrant-vbguest vagrant-mutate
  pip3 install --upgrade pip
  pip3 install ansible fabric3 jsonpickle requests PyYAML firebase_admin
  echo 'export PATH="$HOME/.local/bin:$PATH"' >> $HOME/.bashrc
  source $HOME/.bashrc
}

Open_network_interfaces () {
  sudo mkdir -p /etc/vbox/
  sudo touch /etc/vbox/networks.conf
  sudo sh -c "echo '* 192.168.0.0/16' > /etc/vbox/networks.conf"
  sudo sh -c "echo '* 3001::/64' >> /etc/vbox/networks.conf"

}

LTE_test () {
echo -e ${GREEN}  ${BLACK}
echo -e ${GREEN}#########################################
echo -e ${GREEN}#    **LTE integ test**
echo -e ${GREEN}#########################################${BLACK}
}

lte_integ_test () {
  cd
  cd $MAGMA_ROOT/lte/gateway
  export MAGMA_DEV_CPUS=3
  export MAGMA_DEV_MEMORY_MB=9216
  fab integ_test

}


Magma_repo
Magma_clone
Magma_branch
Pre_requisite
Install_pre_requisites
Open_network_interfaces
LTE_test
lte_integ_test
