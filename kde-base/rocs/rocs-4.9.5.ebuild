# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/rocs/rocs-4.9.5.ebuild,v 1.1 2013/01/05 20:18:39 creffett Exp $

EAPI=4

KDE_HANDBOOK="optional"
inherit kde4-base

DESCRIPTION="KDE4 interface to work with Graph Theory"
KEYWORDS="~amd64 ~arm ~ppc ~x86 ~amd64-linux ~x86-linux"
IUSE="debug"

RDEPEND=">=dev-libs/boost-1.43"
DEPEND="
	${RDEPEND}
	>=dev-cpp/eigen-2.0.3:2
"

src_test() {
	local mycmakeargs=(-DKDE4_BUILD_TESTS=ON)
	cmake-utils_src_configure
	kde4-base_src_compile

	cd "${CMAKE_BUILD_DIR}"
	emake DESTDIR="${T}/tests" install
	export KDEDIRS="${KDEDIRS}:${T}/tests/${PREFIX}"
	kbuildsycoca4
	ctest || die "tests failed"
}
