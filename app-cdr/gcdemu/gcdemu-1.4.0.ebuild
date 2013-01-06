# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/gcdemu/gcdemu-1.4.0.ebuild,v 1.3 2012/05/03 07:51:49 jdhore Exp $

EAPI="4"

PYTHON_DEPEND="2"

inherit gnome2 python

DESCRIPTION="Gtk+ GUI for controlling the CDEmu daemon (cdemud)"
HOMEPAGE="http://cdemu.org/"
SRC_URI="mirror://sourceforge/cdemu/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE="libnotify"

RDEPEND=">=app-cdr/cdemud-1.4.0
	>=dev-python/dbus-python-0.71
	dev-python/gconf-python
	>=dev-python/pygobject-2.6:2
	>=dev-python/pygtk-2.6
	gnome-base/gconf:2

	libnotify? ( dev-python/notify-python )"
DEPEND="${COMMON_DEPEND}
	>=dev-util/intltool-0.21
	virtual/pkgconfig
	sys-devel/gettext"

DOCS="AUTHORS ChangeLog README"

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_prepare() {
	python_convert_shebangs 2 src/gcdemu
	gnome2_src_prepare
}
