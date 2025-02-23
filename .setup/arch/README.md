# Arch Linux Bootstrap Instructions

This guide explains how to bootstrap a new Arch Linux installation using the provided Ansible playbook and related configuration files.

## Prerequisites

1. **Boot into Arch Linux USB Installer**
   - Download the latest Arch Linux ISO and create a bootable USB.
   - Boot the target machine from the USB stick.

2. **Connect to the Internet**
   - If using Wi-Fi: `iwctl` to connect.
   - If wired: you should already have a connection.

3. **Partitioning and Mounting**
   - Use `fdisk`, `cfdisk` or `parted` to partition your disk as you prefer.
   - Mount your chosen root partition to `/mnt`.
   - For example:
     ```bash
     mount /dev/sdXn /mnt
     ```

## Installing Arch with archinstall

1. **Fetch the archinstall config**
   ```bash
   export DOTFILES_GIT_DEFAULT_BRANCH=main
   curl https://raw.githubusercontent.com/LowEntropyEntity/.dotfiles/${DOTFILES_GIT_DEFAULT_BRANCH:-main}/.setup/arch/archinstall.config > /mnt/archinstall.config
   ```

2. **Run archinstall**
   ```bash
   archinstall --config /mnt/archinstall.config --disk /dev/sdX
   ```
Replace `sdX` with your actual disk (e.g., `/dev/nvme0n1`).

Choose a suitable graphics driver.

This should install a base Arch system, apply the configuration, and set up the bootloader.

3. **Reboot into your new Arch system**
   - `umount -R /mnt`
   - `reboot`

   You should now be booted into your new Arch installation.

## Running the Ansible Playbook

1. **Log in as root**

2. **Download the ansible playbook**
   ```bash
   export DOTFILES_GIT_DEFAULT_BRANCH=main
   curl https://raw.githubusercontent.com/LowEntropyEntity/.dotfiles/refs/heads/${DOTFILES_GIT_DEFAULT_BRANCH:-main}/.setup/arch/Makefile > Makefile
   ```

3. **Run `make`**
   - `make` will run download and run the playbook.
   - The playbook will:
     - Attempt to detect whether you have an NVIDIA GPU and install the appropriate drivers and configuration.
     - Install all packages, configure DNS, SSH, etc.

   Enter new username and password when asked. The Ansible play will set up your entire environment

4. **Post-Install Checks**
   - Once Ansible finishes, log out and log back in as your newly created user.
   - Confirm that your environment and tools are working as expected.

