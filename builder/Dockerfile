FROM yangxuan8282/archlinuxarm:aarch64

COPY mirrorlist /etc/pacman.d/mirrorlist

RUN pacman -Syu --noconfirm base-devel git

RUN 	useradd -m -G wheel -s /bin/bash alarm \
	&& echo "alarm:alarm" | chpasswd \
	&& echo "alarm ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers \
	&& pacman -Syu --noconfirm polkit sudo

RUN 	su alarm sh -c 'mkdir -p /home/alarm/work'

RUN pacman -Syu --noconfirm ccache \
  && sed -i 's|!ccache|ccache|' /etc/makepkg.conf \
  && export PATH="/usr/lib/ccache/bin/:$PATH" \
  && sed -i "s|COMPRESSXZ=(xz -c -z -)|COMPRESSXZ=(xz -c -z - --threads=$(nproc))|" /etc/makepkg.conf

RUN sed -i "s/#MAKEFLAGS=\"-j2\"/MAKEFLAGS=\"-j$(nproc)\"/" /etc/makepkg.conf

WORKDIR /home/alarm/work
USER alarm
