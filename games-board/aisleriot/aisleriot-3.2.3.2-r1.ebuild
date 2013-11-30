# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/aisleriot/aisleriot-3.2.3.2-r1.ebuild,v 1.9 2013/11/30 19:00:41 pacho Exp $

EAPI="4"
GCONF_DEBUG="yes"

# make sure games is inherited first so that the gnome2
# functions will be called if they are not overridden
inherit eutils games gnome2 multilib

DESCRIPTION="A collection of solitaire card games for GNOME"
HOMEPAGE="http://live.gnome.org/Aisleriot"

LICENSE="GPL-3 LGPL-3 FDL-1.1"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE="gnome"

# FIXME: quartz support?
COMMON_DEPEND=">=dev-libs/glib-2.26.0:2
	>=dev-scheme/guile-1.8.0:12[deprecated,regex]
	>=gnome-base/librsvg-2.32.0
	>=x11-libs/cairo-1.10.0
	x11-libs/gdk-pixbuf:2
	>=x11-libs/gtk+-3.0.0:3
	x11-libs/libICE
	x11-libs/libSM
	>=media-libs/libcanberra-0.26[gtk3]
	gnome? ( >=gnome-base/gconf-2.0:2 )"
# aisleriot was split off from gnome-games
RDEPEND="${COMMON_DEPEND}
	!<gnome-extra/gnome-games-3.1.1[aisleriot]
	!<gnome-extra/gnome-games-3"
DEPEND="${COMMON_DEPEND}
	>=dev-util/intltool-0.40.4
	virtual/pkgconfig
	sys-apps/lsb-release
	>=sys-devel/gettext-0.12
	gnome? (
		app-text/docbook-xml-dtd:4.3
		>=app-text/yelp-tools-3.1.1 )"

pkg_setup() {
	DOCS="AUTHORS ChangeLog TODO"

	if use gnome; then
		G2CONF="${G2CONF} --with-platform=gnome --with-help-method=ghelp"
	else
		G2CONF="${G2CONF} --with-platform=gtk-only --with-help-method=library
			ITSTOOL=$(type -P true) XMLLINT=$(type -P true)"
	fi

	G2CONF="${G2CONF}
		--with-gtk=3.0
		--with-smclient
		--with-guile=1.8
		--enable-sound
		--disable-schemas-compile
		--with-card-theme-formats=all
		--with-kde-card-theme-path="${EPREFIX}"/usr/share/apps/carddecks
		--with-pysol-card-theme-path=${GAMES_DATADIR}/pysolfc
		--exec-prefix=${GAMES_PREFIX}
		--localstatedir=${GAMES_STATEDIR}
		--with-valgrind-dir="${EPREFIX}"/usr/$(get_libdir)/valgrind"

	export MAKEOPTS="${MAKEOPTS} pkgdatadir=${GAMES_DATADIR}/aisleriot"

	games_pkg_setup
}

src_prepare() {
	epatch "${FILESDIR}/${P}-g_thread_init.patch" #432938
	gnome2_src_prepare
}

src_install() {
	gnome2_src_install
	prepgamesdirs
}

pkg_preinst() {
	gnome2_pkg_preinst
	games_pkg_preinst
}

pkg_postinst() {
	gnome2_pkg_postinst
	games_pkg_postinst

	elog "Aisleriot can use additional card themes from games-board/pysolfc"
	elog "and kde-base/libkdegames."
}
