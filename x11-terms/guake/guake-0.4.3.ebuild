# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-terms/guake/guake-0.4.3.ebuild,v 1.4 2012/08/03 22:28:03 hwoarang Exp $

EAPI=4

GCONF_DEBUG=no
GNOME2_LA_PUNT=yes
PYTHON_DEPEND="2:2.7"
DEB_REV=1

inherit eutils gnome2 python

DESCRIPTION="A dropdown terminal made for the GTK+ desktops"
HOMEPAGE="http://guake.org/"
DEB_URI="mirror://debian/pool/main/${PN:0:1}/${PN}"
SRC_URI="${DEB_URI}/${PN}_${PV}.orig.tar.gz
	${DEB_URI}/${PN}_${PV}-${DEB_REV}.debian.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~arm x86"
IUSE=""

RDEPEND="dev-python/dbus-python
	dev-python/gconf-python
	dev-python/notify-python
	dev-python/pygtk
	dev-python/pyxdg
	gnome-base/gconf
	>=x11-libs/gtk+-2.10:2
	x11-libs/libX11
	x11-libs/vte:0[python]"
DEPEND="${RDEPEND}
	dev-util/intltool
	virtual/pkgconfig"

pkg_setup() {
	DOCS="AUTHORS ChangeLog NEWS README TODO"
	G2CONF="--disable-static"
	python_set_active_version 2
	python_pkg_setup
}

src_prepare() {
	local d=${WORKDIR}/debian/patches
	EPATCH_SOURCE=${d} epatch $(<"${d}"/series)

	python_convert_shebangs 2 src/{guake,prefs.py}

	# We byte-compile in pkg_postinst()
	>py-compile

	# Validate with desktop-file-utils
	sed -i -e '/^Encoding/d' data/*.desktop.in || die

	gnome2_src_prepare
}

pkg_postinst() {
	gnome2_pkg_postinst
	python_mod_optimize ${PN}
}

pkg_postrm() {
	gnome2_pkg_postrm
	python_mod_cleanup ${PN}
}
