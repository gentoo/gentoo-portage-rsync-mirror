# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyatspi/pyatspi-2.2.1.ebuild,v 1.10 2012/10/17 04:29:54 tetromino Exp $

EAPI="4"
GCONF_DEBUG="no"
PYTHON_DEPEND="2:2.5"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.5 3.* *-jython *-pypy-*"

inherit autotools eutils gnome2 python

DESCRIPTION="Python binding to at-spi library"
HOMEPAGE="http://live.gnome.org/Accessibility"

# Note: only some of the tests are GPL-licensed, everything else is LGPL
LICENSE="LGPL-2 GPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~arm ~hppa ~x86"
IUSE="" # test

# test suite is obsolete (at-spi-1.x era) and unpassable
RESTRICT="test"

COMMON_DEPEND="dev-python/dbus-python
	>=dev-python/pygobject-2.90.1:3
"
RDEPEND="${COMMON_DEPEND}
	>=sys-apps/dbus-1
	>=app-accessibility/at-spi2-core-${PV}[introspection]
	!<gnome-extra/at-spi-1.32.0-r1
"
DEPEND="${COMMON_DEPEND}
	virtual/pkgconfig"

pkg_setup() {
	G2CONF="${G2CONF} --disable-tests"
	python_pkg_setup
}

src_prepare() {
	# Fix configure to disable tests properly, upstream bug #670823
	epatch "${FILESDIR}/${PN}-2.2.1-configure-check.patch"

	# remove pygtk cruft; https://bugzilla.gnome.org/show_bug.cgi?id=660826
	# requires eautoreconf
	epatch "${FILESDIR}/${PN}-2.2.0-AM_CHECK_PYMOD-pygtk.patch"
	eautoreconf

	gnome2_src_prepare

	python_clean_py-compile_files
	python_copy_sources
}

src_configure() {
	python_execute_function -s gnome2_src_configure
}

src_compile() {
	python_execute_function -s gnome2_src_compile
}

src_install() {
	python_execute_function -s gnome2_src_install
	python_clean_installation_image
}

pkg_postinst() {
	gnome2_pkg_postinst
	python_mod_optimize pyatspi
}

pkg_postrm() {
	gnome2_pkg_postrm
	python_mod_cleanup pyatspi
}
