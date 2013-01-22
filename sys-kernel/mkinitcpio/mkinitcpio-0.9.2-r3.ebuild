# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/mkinitcpio/mkinitcpio-0.9.2-r3.ebuild,v 1.1 2013/01/22 14:00:48 ssuominen Exp $

EAPI=4

inherit eutils linux-info

DESCRIPTION="Modular initramfs image creation utility ported from Arch Linux"
HOMEPAGE="http://www.archlinux.org/"
MY_MODULES_VER="0_p20120704"
SRC_URI="ftp://ftp.archlinux.org/other/${PN}/${P}.tar.gz
	http://xmw.de/mirror/mkinitcpio-modules/mkinitcpio-modules-${MY_MODULES_VER}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="cryptsetup device-mapper dmraid mdadm pcmcia udev"

DEPEND="sys-apps/sed"
RDEPEND="app-arch/cpio
	app-arch/gzip
	app-arch/libarchive
	app-shells/bash
	>=sys-apps/busybox-1.20[static]
	sys-apps/coreutils
	sys-apps/file
	sys-apps/findutils
	sys-apps/grep
	>=sys-apps/kmod-12-r1
	>=sys-apps/util-linux-2.21
	udev? ( >=virtual/udev-197 )
	device-mapper? ( sys-fs/lvm2[static] )
	cryptsetup? ( sys-fs/cryptsetup[static] )
	mdadm? ( sys-fs/mdadm[static] )
	dmraid? ( sys-fs/dmraid[static] )
	pcmcia? ( || ( >sys-apps/pcmciautils-018[staticsocket] <sys-apps/pcmciautils-018[static] ) )"

pkg_setup() {
	if kernel_is -lt 2 6 32 ; then
		eerror "Sorry, your kernel must be 2.6.32-r103 or newer!"
	fi

	use udev && CONFIG_CHECK+=" ~DEVTMPFS"
	use mdadm && CONFIG_CHECK+=" ~MD ~MD_LINEAR ~MD_RAID0 ~MD_RAID1 ~MD_RAID10 ~MD_RAID456"
	use dmraid && CONFIG_CHECK+=" ~BLK_DEV_DM ~DM_SNAPSHOT ~DM_MIRROR ~DM_RAID ~DM_UEVENT"
	use device-mapper && CONFIG_CHECK+=" ~BLK_DEV_DM ~DM_SNAPSHOT ~DM_UEVENT"
	use cryptsetup && CONFIG_CHECK+=" ~DM_CRYPT"

	linux-info_pkg_setup
}

src_prepare() {
	epatch "${FILESDIR}"/${PN}-base-install.patch
	epatch "${FILESDIR}"/${PN}-consolefont-install.patch
	epatch "${FILESDIR}"/${PN}-keymap-install.patch
	cd "${WORKDIR}"
	epatch "${FILESDIR}"/${PN}-udev-install.patch
	epatch "${FILESDIR}"/${PN}-lvm2-install.patch
	epatch "${FILESDIR}"/${PN}-mdadm_udev-install.patch
	epatch "${FILESDIR}"/${PN}-dmraid-install.patch
	epatch "${FILESDIR}"/${PN}-pcmcia-install.patch
	epatch "${FILESDIR}"/${PN}-encrypt-install.patch
}

src_install() {
	emake DESTDIR="${D}" install

	cd "${WORKDIR}/${PN}-modules-${MY_MODULES_VER}"

	insinto /usr/lib/initcpio/hooks
	use udev && doins hooks/udev
	use device-mapper && doins hooks/lvm2
	if use mdadm ; then
		doins hooks/mdadm
		dosym mdadm /usr/lib/initcpio/hooks/raid
	fi
	use dmraid && doins hooks/dmraid
	use cryptsetup && doins hooks/encrypt

	insinto /usr/lib/initcpio/install
	use udev && doins install/udev
	use device-mapper && doins install/lvm2
	use mdadm && doins install/mdadm{,_udev}
	use dmraid && doins install/dmraid
	use cryptsetup && doins install/encrypt
	use pcmcia && doins install/pcmcia

	if use device-mapper; then
		if use udev; then
			insinto /usr/lib/initcpio/udev/
			doins udev/11-dm-initramfs.rules
		fi
	fi

	dodir /etc/mkinitcpio.d
	sed -e "s/KV/${KV_FULL}/g" \
		"${FILESDIR}"/gentoo.preset \
		> "${D}"/etc/mkinitcpio.d/${KV_FULL}.preset || die
}

pkg_postinst() {
	einfo
	elog "Set your hooks in /etc/mkinitcpio.conf accordingly!"
	elog "Missing hooks can lead to an unbootanle system!"
	einfo
}
