# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/probcons/probcons-1.12-r1.ebuild,v 1.5 2011/06/13 11:17:41 jlec Exp $

EAPI=3

inherit eutils toolchain-funcs

MY_P="${PN}_v${PV/./_}"

DESCRIPTION="Probabilistic Consistency-based Multiple Alignment of Amino Acid Sequences"
HOMEPAGE="http://probcons.stanford.edu/"
SRC_URI="http://probcons.stanford.edu/${MY_P}.tar.gz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="amd64 x86 ~amd64-linux ~x86-linux"
IUSE=""

# Gnuplot is explicitly runtime-only, it's run using system()
RDEPEND="
	!sci-geosciences/gmt
	sci-visualization/gnuplot"
DEPEND=""

S="${WORKDIR}/${PN}"

src_prepare() {
	epatch \
		"${FILESDIR}"/${P}-cxxflags.patch \
		"${FILESDIR}"/gcc-4.3.patch \
		"${FILESDIR}"/${P}-gcc-4.6.patch
}

src_compile() {
	emake \
		CXX="$(tc-getCXX)" \
		OPT_CXXFLAGS="${CXXFLAGS}" \
		|| die "make failed"
}

src_install() {
	dobin probcons project makegnuplot || die "failed to install"
	# Overlap with imagemagick
	newbin compare compare-probcons || die "failed to install compare"
	dodoc README || die
}

pkg_postinst() {
	ewarn "The 'compare' binary is installed as 'compare-probcons'"
	ewarn "to avoid overlap with other packages."
	einfo "You may also want to download the user manual"
	einfo "from http://probcons.stanford.edu/manual.pdf"
}
