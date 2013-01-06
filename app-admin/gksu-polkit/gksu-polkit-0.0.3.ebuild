# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/gksu-polkit/gksu-polkit-0.0.3.ebuild,v 1.1 2012/09/12 11:57:26 tetromino Exp $

EAPI=4

inherit autotools eutils

DESCRIPTION="Polkit-based library and application for running programs as root"
HOMEPAGE="https://live.gnome.org/gksu"
SRC_URI="mirror://debian/pool/main/g/${PN}/${PN}_${PV}.orig.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-libs/dbus-glib
	>=dev-libs/glib-2.14:2
	>=dev-libs/libgee-0.5:0
	sys-auth/polkit
	>=x11-libs/gtk+-2.14:2
	x11-libs/startup-notification"
DEPEND="${DEPEND}
	dev-util/intltool
	virtual/pkgconfig"

src_prepare() {
	# https://alioth.debian.org/tracker/index.php?func=detail&aid=313765&group_id=30351&atid=410861
	epatch "${FILESDIR}/${P}-auth_admin.patch"
	# https://alioth.debian.org/tracker/index.php?func=detail&aid=313766&group_id=30351&atid=410861
	epatch "${FILESDIR}/${P}-gksupkcommon-libs.patch"
	eautoreconf
}

src_configure() {
	econf \
		--disable-static \
		--with-dbus-sys="${EPREFIX}"/etc/dbus-1/system.d
}

src_install() {
	default
	prune_libtool_files
}
