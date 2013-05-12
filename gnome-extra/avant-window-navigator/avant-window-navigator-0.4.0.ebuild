# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/avant-window-navigator/avant-window-navigator-0.4.0.ebuild,v 1.6 2013/05/12 11:50:09 pacho Exp $

EAPI=4
GCONF_DEBUG=no
GNOME2_LA_PUNT=yes
PYTHON_DEPEND="2:2.6"
VALA_MIN_API_VERSION="0.10"
VALA_USE_DEPEND="vapigen"

inherit gnome2 python vala

DESCRIPTION="A dock-like bar which sits at the bottom of the screen"
HOMEPAGE="http://launchpad.net/awn"
SRC_URI="http://launchpad.net/awn/0.4/${PV}/+download/${P}.tar.gz"

LICENSE="GPL-2 LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc +gconf vala"

RDEPEND="
	>=dev-libs/dbus-glib-0.80
	>=dev-libs/glib-2.16
	dev-python/dbus-python
	dev-python/librsvg-python
	dev-python/pycairo
	dev-python/pygobject:2
	>=dev-python/pygtk-2.12:2
	dev-python/pyxdg
	dev-vcs/bzr
	>=gnome-base/libgtop-2
	>=x11-libs/gtk+-2.12:2
	>=x11-libs/libdesktop-agnostic-0.3.9[gconf?]
	>=x11-libs/libwnck-2.22:1
	x11-libs/libX11
	x11-libs/libXcomposite
	x11-libs/libXext
	x11-libs/libXrender
	gconf? ( >=gnome-base/gconf-2 )"
DEPEND="${RDEPEND}
	dev-util/intltool
	virtual/pkgconfig
	sys-devel/gettext
	x11-proto/xproto
	!<gnome-extra/avant-window-navigator-extras-${PV}
	doc? ( dev-util/gtk-doc )
	vala? ( $(vala_depend) )"

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup

	G2CONF="--disable-static
		--disable-pymod-checks
		$(use_enable doc gtk-doc)
		$(use_enable gconf schemas-install)
		$(use_with vala)
		--with-html-dir=/usr/share/doc/${PF}/html"

	DOCS="AUTHORS ChangeLog NEWS README TODO"
}

src_prepare() {
	>py-compile

	gnome2_src_prepare
	use vala && vala_src_prepare
}

pkg_postinst() {
	gnome2_pkg_postinst
	python_mod_optimize awn
}

pkg_postrm() {
	gnome2_pkg_postrm
	python_mod_cleanup awn
}
