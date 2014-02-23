# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/ettercap/ettercap-9999.ebuild,v 1.7 2014/02/23 11:57:34 ago Exp $

EAPI=5

CMAKE_MIN_VERSION=2.8

inherit cmake-utils git-2

DESCRIPTION="A suite for man in the middle attacks"
HOMEPAGE="http://ettercap.sourceforge.net https://github.com/Ettercap/ettercap"
EGIT_REPO_URI="https://github.com/Ettercap/${PN}.git"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS=""
IUSE="gtk ipv6 ncurses +plugins"

RDEPEND="dev-libs/openssl
	dev-libs/libpcre
	net-libs/libnet:1.1
	>=net-libs/libpcap-0.8.1
	sys-libs/zlib
	gtk? (
		>=dev-libs/atk-1.2.4
		>=dev-libs/glib-2.2.2:2
		media-libs/freetype
		x11-libs/cairo
		x11-libs/gdk-pixbuf:2
		>=x11-libs/gtk+-2.2.2:2
		>=x11-libs/pango-1.2.3
	)
	ncurses? ( >=sys-libs/ncurses-5.3 )
	plugins? (
		>=net-misc/curl-7.26.0
		sys-devel/libtool
	)"

DEPEND="${RDEPEND}
	app-text/ghostscript-gpl
	sys-devel/flex
	virtual/yacc"

src_prepare() {
	sed -i "s:Release:Release Gentoo:" CMakeLists.txt || die
}

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_enable ncurses CURSES)
		$(cmake-utils_use_enable gtk)
		$(cmake-utils_use_enable plugins)
		$(cmake-utils_use_enable ipv6)
		-DENABLE_SSL=ON
		-DINSTALL_SYSCONFDIR="${EROOT}"etc
	)
	cmake-utils_src_configure
}
