# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/qbittorrent/qbittorrent-9999.ebuild,v 1.21 2015/03/01 15:49:39 hwoarang Exp $

EAPI=5
PYTHON_COMPAT=( python2_7 )

inherit eutils python-r1 qmake-utils

DESCRIPTION="BitTorrent client in C++ and Qt"
HOMEPAGE="http://www.qbittorrent.org/"
MY_P=${P/_}
if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/${PN}/qBittorrent.git"
	KEYWORDS=""
else
	SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.xz"
	KEYWORDS="~amd64 ~arm ~x86"
fi

LICENSE="GPL-2"
SLOT="0"
IUSE="+dbus debug geoip +qt4 qt5 webui +X"
REQUIRED_USE="^^ ( qt4 qt5 )
	dbus? ( X )
	geoip? ( X )"

# geoip and python are runtime deps only (see INSTALL file)
CDEPEND="
	dev-libs/boost:=
	>=dev-qt/qtsingleapplication-2.6.1_p20130904-r1[X?,qt4?,qt5?]
	>=net-libs/rb_libtorrent-0.16.17
	sys-libs/zlib
	qt4? ( dev-qt/qtcore:4
		dbus? ( dev-qt/qtdbus:4 )
		X? ( dev-qt/qtgui:4 )
		)
	qt5? ( dev-qt/qtcore:5
		dev-qt/qtnetwork:5
		dev-qt/qtxml:5
		dbus? ( dev-qt/qtdbus:5 )
		X? ( dev-qt/qtgui:5
			dev-qt/qtwidgets:5 )
		)
"
DEPEND="${CDEPEND}
	virtual/pkgconfig
"
RDEPEND="${CDEPEND}
	${PYTHON_DEPS}
	geoip? ( dev-libs/geoip )
"

S=${WORKDIR}/${MY_P}
DOCS=(AUTHORS Changelog README.md TODO)

src_prepare() {
	epatch_user
}

src_configure() {
	# Custom configure script, econf fails
	local myconf=(
		./configure
		--prefix="${EPREFIX}/usr"
		--with-qtsingleapplication=system
		$(use dbus  || echo --disable-qt-dbus)
		$(use debug && echo --enable-debug)
		$(use geoip || echo --disable-geoip-database)
		$(use qt5   && echo --with-qt5)
		$(use webui || echo --disable-webui)
		$(use X     || echo --disable-gui)
	)

	echo "${myconf[@]}"
	"${myconf[@]}" || die "configure failed"
	use qt4 && eqmake4
	use qt5 && eqmake5
}

src_install() {
	emake INSTALL_ROOT="${D}" install
}
