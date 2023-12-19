DOTFILES_BRANCH ?= main

all: prepare
	ansible-playbook playbook.yml

prepare:
	curl https://raw.githubusercontent.com/LowEntropyEntity/.dotfiles/$(DOTFILES_BRANCH)/.setup/arch/playbook.yml > playbook.yml
	mkdir -p /etc/ansible
	sh -c 'echo "localhost ansible_connection=local" > /etc/ansible/hosts'
	echo '[defaults]' > /etc/ansible/ansible.cfg
	echo 'log_path = /var/log/ansible.log' >> /etc/ansible/ansible.cfg
