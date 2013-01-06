# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/tomahawk/tomahawk-0.5.5.ebuild,v 1.2 2012/08/10 23:09:31 johu Exp $

EAPI=4

QT_MINIMAL="4.7.0"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="http://download.tomahawk-player.org/${P}.tar.bz2"
	KEYWORDS="~amd64 ~x86"
else
	GIT_ECLASS="git-2"
	EGIT_REPO_URI="git://github.com/tomahawk-player/tomahawk.git"
	KEYWORDS=""
fi

inherit cmake-utils qt4-r2 ${GIT_ECLASS}

DESCRIPTION="Qt playdar social music player"
HOMEPAGE="http://tomahawk-player.org/"

LICENSE="GPL-3 BSD"
SLOT="0"
IUSE="debug jabber twitter"

DEPEND="
	app-crypt/qca
	>=dev-cpp/clucene-2.3.3.4
	>=dev-libs/boost-1.41
	>=dev-libs/libattica-0.4.0
	dev-libs/qjson
	dev-libs/quazip
	>=media-libs/liblastfm-1.0.1
	>=media-libs/libechonest-2.0.1
	>=media-libs/phonon-4.5.0
	media-libs/taglib
	x11-libs/libX11
	>=x11-libs/qt-core-${QT_MINIMAL}:4
	>=x11-libs/qt-dbus-${QT_MINIMAL}:4
	>=x11-libs/qt-gui-${QT_MINIMAL}:4
	>=x11-libs/qt-sql-${QT_MINIMAL}:4[sqlite]
	>=x11-libs/qt-webkit-${QT_MINIMAL}:4
	jabber? ( net-libs/jreen )
	twitter? ( net-libs/qtweetlib )
"
RDEPEND="${DEPEND}
	app-crypt/qca-ossl
"

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_with jabber Jreen)
		$(cmake-utils_use_with twitter QTweetLib)
	)

	if [[ ${PV} != *9999* ]]; then
		mycmakeargs+=( -DBUILD_RELEASE=ON )
	fi

	cmake-utils_src_configure
}

src_compile() {
	cmake-utils_src_compile
}

src_install() {
	cmake-utils_src_install
}
