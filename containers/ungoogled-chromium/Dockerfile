FROM lscr.io/linuxserver/ungoogled-chromium:latest

# for yubikey
RUN apt update && apt install -y \
	libu2f-udev \
	usbutils \
	pcsc-tools \
	&& rm -rf /var/lib/apt/lists/*

