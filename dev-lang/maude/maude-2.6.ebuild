# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/maude/maude-2.6.ebuild,v 1.1 2012/01/26 17:51:48 jlec Exp $

EAPI=4

AUTOTOOLS_AUTORECONF=true

inherit autotools-utils eutils toolchain-funcs versionator

MY_PN="${PN/m/M}"
MY_PV=$(get_version_component_range 1-2)

DESCRIPTION="Maude - A high-level specification language"
HOMEPAGE="http://maude.cs.uiuc.edu/"
SRC_URI="
	http://maude.cs.uiuc.edu/download/current/${MY_PN}-${MY_PV}.tar.gz
	http://dev.gentoo.org/~jlec/distfiles/${P}-extras.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="doc"

RDEPEND="
	>=dev-libs/gmp-4.1.3
	dev-libs/libsigsegv
	dev-libs/libtecla
	sci-libs/buddy"
DEPEND="${RDEPEND}
	sys-devel/bison
	sys-devel/flex"

S="${WORKDIR}"/${MY_PN}-${MY_PV}

PATCHES=(
	"${FILESDIR}"/${PN}-2.5.0-prll.patch
)

src_configure() {
	local myeconfargs=(
		--datadir="${EPREFIX}/usr/share/${PN}"
		)
	autotools-utils_src_configure
}

src_install() {
	autotools-utils_src_install

	insinto /usr/share/${PN}
	doins -r src/Main/*.maude \
		|| die "failed to install data files"

	# Sets the full maude library path.
	doenvd "${FILESDIR}"/23maude || die

	# install full maude
	cd "${WORKDIR}"/${P}-extras
	doins full-maude.maude || die

	# install docs and examples
	if use doc; then
		insinto /usr/share/doc/${P}
		doins -r pdfs/*  || die "failed to install pdf files"

		insinto /usr/share/${PN}/
		doins -r manual-examples primer-examples \
			|| die "failed to install example files"
	fi
}
