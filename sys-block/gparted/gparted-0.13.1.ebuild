# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-block/gparted/gparted-0.13.1.ebuild,v 1.2 2012/12/02 22:24:40 ssuominen Exp $

EAPI=4
GCONF_DEBUG=no

inherit gnome2

DESCRIPTION="Gnome Partition Editor"
HOMEPAGE="http://gparted.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="btrfs dmraid fat gtk hfs jfs kde mdadm ntfs reiserfs reiser4 xfs"

# FIXME: add gpart support
COMMON_DEPEND=">=dev-cpp/gtkmm-2.16:2.4
	>=dev-libs/glib-2
	>=sys-block/parted-3.1"

RDEPEND="${COMMON_DEPEND}
	gtk? ( x11-libs/gksu )
	kde? ( kde-base/kdesu )

	>=sys-fs/e2fsprogs-1.41
	btrfs? ( sys-fs/btrfs-progs )
	dmraid? ( || (
			>=sys-fs/lvm2-2.02.45
			sys-fs/device-mapper )
		sys-fs/dmraid
		sys-fs/multipath-tools )
	fat? (
		sys-fs/dosfstools
		sys-fs/mtools )
	hfs? (
		sys-fs/diskdev_cmds
		virtual/udev
		sys-fs/hfsutils )
	jfs? ( sys-fs/jfsutils )
	mdadm? ( sys-fs/mdadm )
	ntfs? ( >=sys-fs/ntfs3g-2011.4.12[ntfsprogs] )
	reiserfs? ( sys-fs/reiserfsprogs )
	reiser4? ( sys-fs/reiser4progs )
	xfs? ( sys-fs/xfsprogs sys-fs/xfsdump )"

DEPEND="${COMMON_DEPEND}
	app-text/docbook-xml-dtd:4.1.2
	app-text/gnome-doc-utils
	app-text/rarian
	dev-util/intltool
	virtual/pkgconfig"

DOCS="AUTHORS ChangeLog NEWS README"

src_configure() {
	G2CONF="${G2CONF}
		--enable-doc
		GKSUPROG=$(type -P true)"
	gnome2_src_configure
}

src_prepare() {
	sed -i -e 's:Exec=@gksuprog@ :Exec=:' gparted.desktop.in.in || die
	gnome2_src_prepare
}

src_install() {
	gnome2_src_install

	local _ddir="${D}"/usr/share/applications

	if use kde; then
		cp "${_ddir}"/gparted{,-kde}.desktop
		sed -i -e 's:Exec=:Exec=kdesu :' "${_ddir}"/gparted-kde.desktop
		echo 'OnlyShowIn=KDE;' >> "${_ddir}"/gparted-kde.desktop
	fi

	if use gtk; then
		sed -i -e 's:Exec=:Exec=gksu :' "${_ddir}"/gparted.desktop
		echo 'NotShowIn=KDE;' >> "${_ddir}"/gparted.desktop
	else
		echo 'OnlyShowIn=X-NeverShowThis;' >> "${_ddir}"/gparted.desktop
	fi
}
