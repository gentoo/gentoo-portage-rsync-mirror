# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-backup/deja-dup/deja-dup-25.3.ebuild,v 1.1 2013/02/05 07:29:14 jlec Exp $

EAPI=5

GNOME2_LA_PUNT="yes"

inherit eutils gnome2

DESCRIPTION="Simple backup tool using duplicity back-end"
HOMEPAGE="https://launchpad.net/deja-dup/"
SRC_URI="http://launchpad.net/${PN}/26/${PV}/+download/${P}.tar.xz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="nautilus"

RESTRICT="test"

VALA_VER="0.16"

COMMON_DEPEND="
	app-crypt/libsecret[vala]
	dev-libs/glib:2
	dev-libs/libpeas
	x11-libs/gtk+:3
	x11-libs/libnotify

	app-backup/duplicity
	dev-libs/dbus-glib

	nautilus? ( gnome-base/nautilus )"
RDEPEND="${COMMON_DEPEND}
	gnome-base/gvfs[fuse]"
DEPEND="${COMMON_DEPEND}
	app-text/yelp-tools
	dev-lang/vala:${VALA_VER}
	dev-perl/Locale-gettext
	virtual/pkgconfig
	dev-util/intltool
	sys-devel/gettext"

#PATCHES=( "${FILESDIR}"/${P}-desktop.patch )

src_prepare() {
	DOCS="NEWS AUTHORS"
	G2CONF="${G2CONF}
		$(use_with nautilus)
		--without-ccpanel
		--without-unity
		--disable-schemas-compile
		--disable-static"
	export VALAC=$(type -p valac-${VALA_VER})

#	epatch ${PATCHES[@]}

	gnome2_src_prepare
}
