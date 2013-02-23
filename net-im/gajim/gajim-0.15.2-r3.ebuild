# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/gajim/gajim-0.15.2-r3.ebuild,v 1.2 2013/02/23 10:32:18 jlec Exp $

EAPI=4

PYTHON_DEPEND="2"
PYTHON_USE_WITH="sqlite xml"

inherit autotools eutils python versionator

DESCRIPTION="Jabber client written in PyGTK"
HOMEPAGE="http://www.gajim.org/"
SRC_URI="http://www.gajim.org/downloads/$(get_version_component_range 1-2)/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="alpha amd64 ~arm ~hppa ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE="avahi crypt dbus gnome kde idle jingle libnotify networkmanager nls spell +srv X xhtml"

REQUIRED_USE="
	libnotify? ( dbus )
	avahi? ( dbus )"

COMMON_DEPEND="
	dev-python/pygtk:2
	x11-libs/gtk+:2"
DEPEND="${COMMON_DEPEND}
	>=dev-util/intltool-0.40.1
	virtual/pkgconfig
	>=sys-devel/gettext-0.17-r1"
RDEPEND="${COMMON_DEPEND}
	dev-python/pyasn1
	dev-python/pyopenssl
	crypt? (
		app-crypt/gnupg
		dev-python/pycrypto
		)
	dbus? (
		dev-python/dbus-python
		dev-libs/dbus-glib
		libnotify? ( dev-python/notify-python )
		avahi? ( net-dns/avahi[dbus,gtk,python] )
		)
	gnome? (
		dev-python/libgnome-python
		dev-python/gnome-keyring-python
		dev-python/egg-python
		)
	idle? ( x11-libs/libXScrnSaver )
	jingle? ( net-libs/farstream:0.1[python] )
	kde? ( kde-base/kwallet )
	networkmanager? (
			dev-python/dbus-python
			net-misc/networkmanager
		)
	spell? ( app-text/gtkspell:2 )
	srv? (
		|| (
			dev-python/libasyncns-python
			net-dns/bind-tools )
		)
	xhtml? ( dev-python/docutils )"

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_prepare() {
	echo "src/command_system/mapping.py" >> po/POTFILES.in
	epatch \
		"${FILESDIR}"/0.14-python-version.patch \
		"${FILESDIR}"/0.14.1-testing.patch \
		"${FILESDIR}"/${P}-CVE-2012-5524.patch
	echo '#!/bin/sh' > config/py-compile
	eautoreconf
}

src_configure() {
	econf \
		$(use_enable nls) \
		$(use_with X x) \
		--docdir="/usr/share/doc/${PF}" \
		--libdir="$(python_get_sitedir)" \
		--enable-site-packages
}

src_install() {
	default

	rm "${D}/usr/share/doc/${PF}/README.html" || die
	dohtml README.html
}

pkg_postinst() {
	python_mod_optimize ${PN}
}

pkg_postrm() {
	python_mod_cleanup ${PN}
}
