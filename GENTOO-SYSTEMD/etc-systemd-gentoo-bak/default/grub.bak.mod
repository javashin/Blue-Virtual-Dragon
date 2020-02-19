# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
#
# To populate all changes in this file you need to regenerate your
# grub configuration file afterwards:
#     'grub2-mkconfig -o /boot/grub/grub.cfg'
#
# See the grub info page for documentation on possible variables and
# their associated values.

GRUB_DISTRIBUTOR="Gentoo"

# Default menu entry
GRUB_DEFAULT=0

# Boot the default entry this many seconds after the menu is displayed
GRUB_TIMEOUT=5
GRUB_TIMEOUT_STYLE=menu

# Append parameters to the linux kernel command line
GRUB_CMDLINE_LINUX="dozfs real_root=ZFS=zroot/ROOT/Gentoo real_resume=UUID=88fb0f40-003e-4d36-a7cf-4d68126afd05 spl.spl_hostid=0x5e2a4d6f rootfstype=zfs rootflags=rw,noatime,xattr,posixacl resume=UUID=88fb0f40-003e-4d36-a7cf-4d68126afd05 nowatchdog nmi_watchdog=0 psmouse.synaptics_intertouch=0 scsi_mod.use_blk_mq=0 libahci.ignore_sss=1 loglevel=2 i915.fastboot=1 mitigations=off ipv6.disable=1 audit=0 net.ifnames=0 zswap.enabled=1 zswap.compressor=lz4 zswap.max_pool_percent=20 zswap.zpool=z3fold zram.num_devices=4 zram_num.devices=4 vt.global_cursor_default=0 rd.systemd.show_status=false systemd.show_status=false rd.udev.log_priority=2 ksm_mode=always nomodeset logo i915.modeset=0 init=/lib/systemd/systemd"
#zfs.zfs_arc_max=536870912

#spl.spl_hostid=0x5e2a4d6f rootfstype=btrfs rootflags=rw,noatime,compress-force=zstd:3,space_cache=v2,autodefrag,subvolid=257,subvol=/Gentoo resume=UUID=88fb0f40-003e-4d36-a7cf-4d68126afd05 nowatchdog nmi_watchdog=0 psmouse.synaptics_intertouch=0 scsi_mod.use_blk_mq=0 libahci.ignore_sss=1 loglevel=2 i915.fastboot=1 mitigations=off ipv6.disable=1 audit=0 net.ifnames=0 zswap.enabled=1 zswap.compressor=lz4 zswap.max_pool_percent=20 zswap.zpool=z3fold zram.num_devices=4 zram_num.devices=4 vt.global_cursor_default=0 rd.systemd.show_status=false systemd.show_status=false rd.udev.log_priority=2 init=/lib/systemd/systemd"
#
# Examples:
#
# Boot with network interface renaming disabled
# GRUB_CMDLINE_LINUX="net.ifnames=0"
#
# Boot with systemd instead of sysvinit (openrc)
# GRUB_CMDLINE_LINUX="init=/usr/lib/systemd/systemd"

# Append parameters to the linux kernel command line for non-recovery entries
#GRUB_CMDLINE_LINUX_DEFAULT=""

# Uncomment to disable graphical terminal (grub-pc only)
#GRUB_TERMINAL=console

# The resolution used on graphical terminal.
# Note that you can use only modes which your graphic card supports via VBE.
# You can see them in real GRUB with the command `vbeinfo'.
GRUB_GFXMODE=1366x768

# Set to 'text' to force the Linux kernel to boot in normal text
# mode, 'keep' to preserve the graphics mode set using
# 'GRUB_GFXMODE', 'WIDTHxHEIGHT'['xDEPTH'] to set a particular
# graphics mode, or a sequence of these separated by commas or
# semicolons to try several modes in sequence.
GRUB_GFXPAYLOAD_LINUX=keep

# Path to theme spec txt file.
# The starfield is by default provided with use truetype.
# NOTE: when enabling custom theme, ensure you have required font/etc.
#GRUB_THEME="/boot/grub/themes/starfield/theme.txt"

# Background image used on graphical terminal.
# Can be in various bitmap formats.
#GRUB_BACKGROUND="/boot/grub/mybackground.png"

# Uncomment if you don't want GRUB to pass "root=UUID=xxx" parameter to kernel
#GRUB_DISABLE_LINUX_UUID=true

# Uncomment to disable generation of recovery mode menu entries
#GRUB_DISABLE_RECOVERY=true

# Uncomment to disable generation of the submenu and put all choices on
# the top-level menu.
# Besides the visual affect of no sub menu, this makes navigation of the
# menu easier for a user who can't see the screen.
#GRUB_DISABLE_SUBMENU=y

# Uncomment to play a tone when the main menu is displayed.
# This is useful, for example, to allow users who can't see the screen
# to know when they can make a choice on the menu.
#GRUB_INIT_TUNE="60 800 1"
