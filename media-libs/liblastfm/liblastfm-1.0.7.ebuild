# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/liblastfm/liblastfm-1.0.7.ebuild,v 1.2 2013/08/14 09:58:19 jlec Exp $

EAPI=5

QT_MINIMAL="4.8.0"
inherit cmake-utils

DESCRIPTION="A Qt C++ library for the Last.fm webservices"
HOMEPAGE="https://github.com/lastfm/liblastfm"
SRC_URI="https://github.com/lastfm/liblastfm/archive/${PV}.tar.gz -> ${P}.tar.gz"

SLOT="0"
LICENSE="GPL-3"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux"
IUSE="examples fingerprint qt4 test"

COMMON_DEPEND="
	>=dev-qt/qtcore-${QT_MINIMAL}:4
	>=dev-qt/qtdbus-${QT_MINIMAL}:4
	fingerprint? (
		media-libs/libsamplerate
		sci-libs/fftw:3.0
		>=dev-qt/qtsql-${QT_MINIMAL}:4
	)
"
DEPEND="${COMMON_DEPEND}
	test? ( >=dev-qt/qttest-${QT_MINIMAL}:4 )
"
RDEPEND="${COMMON_DEPEND}
	!<media-libs/lastfmlib-0.4.0
"

# 1 of 2 is failing, last checked 2012-06-22 / version 1.0.1
RESTRICT="test"

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_find_package !qt4 Qt5Core)
		$(cmake-utils_use_build examples DEMOS)
		$(cmake-utils_use_build fingerprint FINGERPRINT)
		$(cmake-utils_use_build test TESTS)
	)
	cmake-utils_src_configure
}
