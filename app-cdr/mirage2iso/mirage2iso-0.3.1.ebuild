# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/mirage2iso/mirage2iso-0.3.1.ebuild,v 1.6 2012/08/30 22:47:22 mgorny Exp $

EAPI=4

inherit autotools-utils toolchain-funcs versionator

TESTS_PV=$(get_version_component_range 1-2)

DESCRIPTION="CD/DVD image converter using libmirage"
HOMEPAGE="https://bitbucket.org/mgorny/mirage2iso/"
SRC_URI="mirror://bitbucket/mgorny/${PN}/downloads/${P}.tar.bz2
	test? ( mirror://bitbucket/mgorny/${PN}/downloads/${PN}-${TESTS_PV}-tests.tar.xz )"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="pinentry test"

COMMON_DEPEND="dev-libs/libmirage
	dev-libs/glib:2
	pinentry? ( dev-libs/libassuan )"
DEPEND="${COMMON_DEPEND}
	virtual/pkgconfig
	test? ( app-arch/xz-utils )"
RDEPEND="${COMMON_DEPEND}
	pinentry? ( app-crypt/pinentry )"

DOCS=( NEWS README )

src_configure() {
	local pkgconf=$(tc-getPKG_CONFIG)

	myeconfargs=(
		$(use_with pinentry libassuan)

		# ai, upstream missed it
		CFLAGS="${CFLAGS} $(${pkgconf} --cflags gobject-2.0)"
		LIBS="${LIBS} $(${pkgconf} --libs gobject-2.0)"
	)

	autotools-utils_src_configure
}

src_test() {
	mv "${WORKDIR}"/${PN}-${TESTS_PV}/tests/* tests/ || die
	autotools-utils_src_test
}
