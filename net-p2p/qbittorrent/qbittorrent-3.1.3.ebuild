# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/qbittorrent/qbittorrent-3.1.3.ebuild,v 1.1 2013/11/22 22:27:56 hwoarang Exp $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7} )

inherit python-r1 qt4-r2

MY_P="${P/_/}"
DESCRIPTION="BitTorrent client in C++ and Qt"
HOMEPAGE="http://www.qbittorrent.org/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE="dbus +X geoip"

# python-2 is a runtime dep only, for the search engine (see INSTALL file)
CDEPEND="dev-libs/boost
	dev-qt/qtcore:4
	dev-qt/qtsingleapplication
	>=net-libs/rb_libtorrent-0.16.3
	X? ( dev-qt/qtgui:4 )
	dbus? ( dev-qt/qtdbus:4 )"
DEPEND="${CDEPEND}
	virtual/pkgconfig"
RDEPEND="${CDEPEND}
	${PYTHON_DEPS}
	geoip? ( dev-libs/geoip )"

DOCS="AUTHORS Changelog NEWS README TODO"
S="${WORKDIR}/${MY_P}"

src_prepare() {
	# Respect LDFLAGS
	sed -i -e 's/-Wl,--as-needed/$(LDFLAGS)/g' src/src.pro
	qt4-r2_src_prepare
}

src_configure() {
	local myconf
	use geoip     || myconf+=" --disable-geoip-database"
	use dbus 	  || myconf+=" --disable-qt-dbus"

	# 491494 workaround
	if use X; then
		myconf+=" --with-qtsingleapplication=system"
	else
		myconf+=" --disable-gui"
	fi

	# econf fails, since this uses qconf
	./configure --prefix=/usr --qtdir=/usr \
		--with-libboost-inc=/usr/include/boost \
		${myconf} || die "configure failed"
	eqmake4
}
