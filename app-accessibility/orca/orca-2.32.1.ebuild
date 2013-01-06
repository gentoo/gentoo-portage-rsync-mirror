# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-accessibility/orca/orca-2.32.1.ebuild,v 1.11 2012/12/16 07:53:08 tetromino Exp $

EAPI="3"
GCONF_DEBUG="no"
PYTHON_DEPEND="2"

inherit gnome2 python

DESCRIPTION="Extensible screen reader that provides access to the desktop"
HOMEPAGE="http://projects.gnome.org/orca/"

LICENSE="LGPL-2+"
SLOT="0"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE=""

# liblouis is not in portage yet
# it is used to provide contracted braille support
RDEPEND=">=dev-libs/glib-2.10:2
	>=gnome-extra/at-spi-1.32:1
	>=gnome-base/orbit-2
	>=dev-python/pyorbit-2.24
	>=gnome-base/libbonobo-2.24
	>=dev-python/libbonobo-python-2.24

	dev-python/pygobject:2
	dev-python/pycairo
	dev-python/pyxdg
	>=dev-python/dbus-python-0.83
	>=dev-python/pygtk-2.12:2

	>=dev-python/libwnck-python-2.24
	>=dev-python/gconf-python-2.24
	>=dev-python/libgnome-python-2.14

	>=app-accessibility/gnome-speech-0.3.10
	>=app-accessibility/gnome-mag-0.12.5"

DEPEND="${RDEPEND}
	>=dev-util/intltool-0.40
	virtual/pkgconfig"

pkg_setup() {
	DOCS="AUTHORS ChangeLog MAINTAINERS NEWS README TODO"
	python_set_active_version 2
}

src_prepare() {
	gnome2_src_prepare

	# disable pyc compiling
	echo > py-compile
}

src_configure() {
	# FIXME: Workaround for bug #325611 until root cause is found
	addpredict "$(unset HOME; echo ~)/.gconf"
	addpredict "$(unset HOME; echo ~)/.gconfd"
	# Needed for import pyatspi
	unset DBUS_SESSION_BUS_ADDRESS
	PYTHON="$(PYTHON)" gnome2_src_configure
}

src_compile() {
	# FIXME: Workaround for bug #325611 until root cause is found
	addpredict "$(unset HOME; echo ~)/.gconf"
	addpredict "$(unset HOME; echo ~)/.gconfd"
	gnome2_src_compile
}

pkg_postinst() {
	gnome2_pkg_postinst
	python_mod_optimize "${PN}"
}

pkg_postrm() {
	gnome2_pkg_postrm
	python_mod_cleanup "${PN}"
}
