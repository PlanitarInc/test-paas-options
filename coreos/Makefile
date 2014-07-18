NINSTANCES=5
FLEETCTL_TUNNEL=172.17.8.101

.PHONY: all run config stop clean

all: run

run: config coreos-vagrant/.vagrant/up-to-date
	(cd coreos-vagrant && vagrant up --provider=virtualbox)
	ssh-add ~/.vagrant.d/insecure_private_key
	ssh -A -o StrictHostKeyChecking=no \
	  -o UserKnownHostsFile=~/.fleetctl/known_hosts \
	  core@${FLEETCTL_TUNNEL} true
	fleetctl --tunnel=${FLEETCTL_TUNNEL} --strict-host-key-checking=false \
	  list-machines
	@echo -e '\n\nUse the following tunnel url:'
	@echo -e '  export FLEETCTL_TUNNEL=${FLEETCTL_TUNNEL}'

stop:
	(cd coreos-vagrant && vagrant halt)

clean: 
	(cd coreos-vagrant && vagrant destroy -f)
	rm -f coreos-vagrant/user-data coreos-vagrant/discovery-url \
	  coreos-vagrant/config.rb ~/.fleetctl/known_hosts \
	  coreos-vagrant/.vagrant/up-to-date

config: coreos-vagrant/.vagrant/up-to-date

coreos-vagrant/.vagrant/up-to-date: coreos-vagrant/config.rb \
  coreos-vagrant/user-data coreos-vagrant/discovery-url
	(cd coreos-vagrant && vagrant destroy -f)
	rm -f ~/.fleetctl/known_hosts
	touch $@

deploy:
	fleetctl --tunnel=${FLEETCTL_TUNNEL} --strict-host-key-checking=false \
	  start test-app/*
	fleetctl --tunnel=${FLEETCTL_TUNNEL} --strict-host-key-checking=false \
	  list-units

undeploy:
	fleetctl --tunnel=${FLEETCTL_TUNNEL} --strict-host-key-checking=false \
	  destroy test-app/*
	fleetctl --tunnel=${FLEETCTL_TUNNEL} --strict-host-key-checking=false \
	  list-units

coreos-vagrant/discovery-url:
	curl -s https://discovery.etcd.io/new > $@

coreos-vagrant/user-data: coreos-vagrant/user-data.sample \
  coreos-vagrant/discovery-url
	sed $< >$@ \
	  -e 's!^\([ ]*\)#\(discovery:\).*$$!\1\2 '$$(cat coreos-vagrant/discovery-url)'!'

coreos-vagrant/config.rb:
	echo > $@
	echo '$$num_instances=${NINSTANCES}' >> $@
	echo '$$update_channel="alpha"' >> $@
	echo '$$enable_serial_logging=false' >> $@
	echo '$$vb_gui=false' >> $@
	echo '$$vb_memory=256' >> $@
	echo '$$vb_cpus=1' >> $@

