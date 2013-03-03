# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/qtm/qtm-1.3.10.ebuild,v 1.4 2013/03/02 23:05:44 hwoarang Exp $

EAPI="2"

inherit cmake-utils

DESCRIPTION="Qt4 blogging client"
HOMEPAGE="http://qtm.blogistan.co.uk"
SRC_URI="mirror://sourceforge/catkin/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="dbus debug ssl"
RESTRICT="strip"

RDEPEND="dev-qt/qtgui:4
	dbus? ( dev-qt/qtdbus:4 )
	x11-proto/xproto
	dev-lang/perl
	virtual/perl-Digest-MD5"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

CMAKE_IN_SOURCE_BUILD="1"

DOCS="Changelog README"

src_configure() {
	mycmakeargs="-DDONT_USE_PTE=FALSE -DINSTALL_MARKDOWN=TRUE
	$(cmake-utils_use debug QDEBUG)
	$(cmake-utils_use ssl)"
	! use dbus && mycmakeargs="${mycmakeargs} -DDONT_USE_DBUS=TRUE"
	cmake-utils_src_configure
}
