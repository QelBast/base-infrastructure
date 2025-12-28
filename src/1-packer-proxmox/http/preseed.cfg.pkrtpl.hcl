# TODO: Сделать templatefile с подстановкой секретов

d-i debian-installer/locale string en_US.UTF-8
d-i debian-installer/language string en
d-i debian-installer/country string US
d-i localechooser/supported-locales multiselect en_US.UTF-8
d-i keyboard-configuration/layoutcode string us
d-i keyboard-configuration/xkb-keymap select us
d-i console-setup/ask_detect boolean false
d-i countrychooser/shortlist select US
d-i countrychooser/country-name select United States

d-i netcfg/choose_interface select auto
d-i netcfg/use_dhcp boolean true
d-i netcfg/hostname string ${hostname}
# hostname
d-i netcfg/get_hostname string ${hostname}
d-i netcfg/hostname_seen boolean true
d-i netcfg/get_domain string ${domain}

d-i mirror/http/hostname string deb.debian.org
d-i mirror/http/directory string /debian
d-i mirror/http/proxy string

d-i passwd/root-password password ${root_password}
d-i passwd/root-password-again password ${root_password}
d-i passwd/root-login boolean false

# Create a user
d-i passwd/make-user boolean true
d-i passwd/user-fullname string ${fullname}
d-i passwd/username string ${username}
d-i passwd/user-password password ${password}
d-i passwd/user-password-again password ${password}
d-i passwd/user-default-groups string audio cdrom video sudo

# User timezone
d-i clock-setup/utc boolean true
d-i time/zone string ${timezone}

d-i partman-auto/init_automatically_partition select biggest_free
d-i partman-auto/method string lvm
d-i partman-lvm/device_remove_lvm boolean true
d-i partman-lvm/confirm_nooverwrite boolean true
d-i partman-lvm/confirm boolean true
d-i partman-auto/choose_recipe select atomic
d-i partman-auto/confirm boolean true

d-i partman-md/confirm boolean true
d-i partman-partitioning/confirm_write_new_label boolean true
d-i partman/choose_partition select finish
d-i partman/confirm boolean true
d-i partman/confirm_nooverwrite boolean true

tasksel tasksel/first multiselect standard, ssh-server

d-i grub-installer/only_debian boolean true
d-i grub-installer/bootdev string default

d-i finish-install/reboot_in_progress note