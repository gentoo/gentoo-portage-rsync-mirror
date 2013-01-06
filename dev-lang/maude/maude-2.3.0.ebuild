# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/maude/maude-2.3.0.ebuild,v 1.4 2010/06/23 14:24:31 jlec Exp $

inherit toolchain-funcs eutils versionator

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

RDEPEND="sci-libs/buddy
	dev-libs/libtecla
	>=dev-libs/gmp-4.1.3"

DEPEND="${RDEPEND}
	sys-devel/bison
	sys-devel/flex"

S="${WORKDIR}"/${MY_PN}-${MY_PV}

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/${P}-gcc43.patch
}

src_compile() {
	econf || die "econf failed"
	emake -j1 || die "emake failed"
}

src_install() {
	make install DESTDIR="${D}" || die "make install failed"
	dodoc AUTHORS ChangeLog NEWS README

	insinto /usr/share/${PN}
	doins -r src/Main/*.maude \
		|| die "failed to install data files"

	# Sets the full maude library path.
	doenvd "${FILESDIR}"/23maude

	# install full maude
	cd "${WORKDIR}"/${P}-extras
	doins full-maude.maude

	# install docs and examples
	if use doc; then
		insinto /usr/share/doc/${P}
		doins -r pdfs/*  || die "failed to install pdf files"

		insinto /usr/share/${PN}/
		doins -r manual-examples primer-examples \
			|| die "failed to install example files"
	fi
}
