# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/gajim/gajim-0.15.4.ebuild,v 1.12 2014/05/13 14:43:27 ago Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7} )
PYTHON_REQ_USE="sqlite,xml"

AUTOTOOLS_AUTORECONF=true

inherit autotools-utils python-r1 versionator

DESCRIPTION="Jabber client written in PyGTK"
HOMEPAGE="http://www.gajim.org/"
SRC_URI="
	http://www.gajim.org/downloads/$(get_version_component_range 1-2)/${P}.tar.bz2"
#	test? ( http://dev.gentoo.org/~jlec/distfiles/${PN}-tests-${PV}.tar.xz )"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm ia64 ppc ppc64 ~sparc x86 ~x86-fbsd"
IUSE="avahi crypt dbus gnome gnome-keyring kde idle jingle libnotify networkmanager nls spell +srv test X xhtml"

REQUIRED_USE="
	${PYTHON_REQUIRED_USE}
	libnotify? ( dbus )
	avahi? ( dbus )
	gnome? ( gnome-keyring )"

COMMON_DEPEND="
	${PYTHON_DEPS}
	dev-python/pygtk:2[${PYTHON_USEDEP}]
	x11-libs/gtk+:2"
DEPEND="${COMMON_DEPEND}
	>=dev-util/intltool-0.40.1
	virtual/pkgconfig
	>=sys-devel/gettext-0.17-r1"
RDEPEND="${COMMON_DEPEND}
	dev-python/pyasn1[${PYTHON_USEDEP}]
	dev-python/pyopenssl[${PYTHON_USEDEP}]
	crypt? (
		app-crypt/gnupg
		dev-python/pycrypto[${PYTHON_USEDEP}]
		)
	dbus? (
		dev-python/dbus-python[${PYTHON_USEDEP}]
		dev-libs/dbus-glib
		libnotify? ( dev-python/notify-python[${PYTHON_USEDEP}] )
		avahi? ( net-dns/avahi[dbus,gtk,python] )
		)
	gnome? (
		dev-python/libgnome-python
		dev-python/egg-python
		)
	gnome-keyring? (
		dev-python/gnome-keyring-python
		)
	idle? ( x11-libs/libXScrnSaver )
	jingle? ( net-libs/farstream:0.1[python] )
	kde? ( kde-base/kwalletmanager )
	networkmanager? (
			dev-python/dbus-python[${PYTHON_USEDEP}]
			net-misc/networkmanager
		)
	spell? ( app-text/gtkspell:2 )
	srv? (
		|| (
			dev-python/libasyncns-python
			net-dns/bind-tools )
		)
	xhtml? ( dev-python/docutils )"

RESTRICT="test"

PATCHES=(
	"${FILESDIR}"/${PN}-0.15.3-roster.patch
	)

src_prepare() {
	echo "src/command_system/mapping.py" >> po/POTFILES.in
	echo '#!/bin/sh' > config/py-compile
	autotools-utils_src_prepare
	python_copy_sources
}

src_configure() {
	configuration() {
		local myeconfargs=(
			$(use_enable nls)
			$(use_with X x)
			--docdir="/usr/share/doc/${PF}"
			--libdir="$(python_get_sitedir)"
			--enable-site-packages
		)
		run_in_build_dir autotools-utils_src_configure
	}
	python_foreach_impl configuration
}

src_compile() {
	compilation() {
		run_in_build_dir autotools-utils_src_compile
	}
	python_foreach_impl compilation
}

src_test() {
	testing() {
		run_in_build_dir ${PYTHON} test/runtests.py --verbose 3 || die
	}
	python_foreach_impl testing
}

src_install() {
	installation() {
		run_in_build_dir autotools-utils_src_install
		python_optimize "${ED}"/$(python_get_sitedir)
	}
	python_foreach_impl installation

	rm "${D}/usr/share/doc/${PF}/README.html" || die
	dohtml README.html
}
