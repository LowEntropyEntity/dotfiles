all: prepare
	ansible-playbook playbook.yml

prepare:
	curl https://raw.githubusercontent.com/LowEntropyEntity/.dotfiles/main/.setup/arch/playbook.yml > playbook.yml
	pacman -S --noconfirm ansible
	mkdir -p /etc/ansible
	sh -c 'echo "localhost ansible_connection=local" > /etc/ansible/hosts'
