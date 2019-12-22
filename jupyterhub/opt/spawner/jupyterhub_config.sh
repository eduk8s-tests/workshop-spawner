CONFIGURATION_TYPE=${CONFIGURATION_TYPE:-hosted-workshop}

if [ -f /opt/spawner/configs/${CONFIGURATION_TYPE}.sh ]; then
    . /opt/spawner/configs/${CONFIGURATION_TYPE}.sh
fi

if [ -f /var/run/spawner/configs/jupyterhub_config.sh ]; then
    . /var/run/spawner/configs/jupyterhub_config.sh
fi
