# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/avant-window-navigator/avant-window-navigator-0.4.0.ebuild,v 1.8 2014/02/27 17:59:48 ssuominen Exp $

EAPI=5
GCONF_DEBUG=no
GNOME2_LA_PUNT=yes
PYTHON_COMPAT=( python2_7 )
VALA_MIN_API_VERSION=0.10
VALA_USE_DEPEND=vapigen

inherit autotools eutils gnome2 python-single-r1 vala

DESCRIPTION="A dock-like bar which sits at the bottom of the screen"
HOMEPAGE="http://launchpad.net/awn"
SRC_URI="http://launchpad.net/awn/${PV%.*}/${PV}/+download/${P}.tar.gz"

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
	${PYTHON_DEPS}
	gconf? ( >=gnome-base/gconf-2 )"
DEPEND="${RDEPEND}
	dev-util/intltool
	sys-devel/gettext
	virtual/pkgconfig
	x11-proto/xproto
	!<gnome-extra/avant-window-navigator-extras-${PV}
	doc? ( dev-util/gtk-doc )
	vala? ( $(vala_depend) )"

pkg_setup() {
	python-single-r1_pkg_setup

	G2CONF="--disable-static
		--disable-pymod-checks
		$(use_enable doc gtk-doc)
		$(use_enable gconf schemas-install)
		--disable-shave
		$(use_with vala)
		--with-html-dir=/usr/share/doc/${PF}/html"

	DOCS="AUTHORS ChangeLog NEWS README TODO"
}

src_prepare() {
	epatch "${FILESDIR}"/${P}-underlinking.patch
	eautoreconf

	python_fix_shebang awn-settings/awnSettings{.py.in,Helper.py}

	gnome2_src_prepare
	use vala && vala_src_prepare
}
