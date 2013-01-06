# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/maude/maude-2.5.0.ebuild,v 1.2 2010/06/23 14:28:14 jlec Exp $

EAPI="3"

inherit autotools eutils toolchain-funcs versionator

MY_PN="${PN/m/M}"
MY_PV=$(get_version_component_range 1-2)

DESCRIPTION="Maude - A high-level specification language"
HOMEPAGE="http://maude.cs.uiuc.edu/"
SRC_URI="http://maude.cs.uiuc.edu/download/current/${MY_PN}-${MY_PV}.tar.gz
		mirror://gentoo/${P}-extras.tar.bz2"

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

src_prepare() {
	epatch "${FILESDIR}"/${P}-prll.patch
	eautoreconf
}

src_configure() {
	econf --datadir="${EPREFIX}/usr/share/${PN}"
}

src_install() {
	make install DESTDIR="${D}" || die "make install failed"
	dodoc AUTHORS ChangeLog NEWS README

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
