# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/burrow-owl/burrow-owl-1.4-r1.ebuild,v 1.2 2012/05/04 07:02:34 jdhore Exp $

EAPI="2"

inherit autotools base virtualx

DESCRIPTION="Visualize multidimensional nuclear magnetic resonance (NMR) spectra"
HOMEPAGE="http://burrow-owl.sourceforge.net/"
SRC_URI="examples? ( mirror://sourceforge/${PN}/burrow-demos.tar )
		mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="examples"

RDEPEND="dev-scheme/guile[networking,regex]
	dev-scheme/guile-gnome-platform
	>=dev-scheme/guile-cairo-1.4
	>=sci-libs/starparse-1.0
	x11-libs/gtk+:2"
DEPEND="${RDEPEND}
	dev-util/indent
	virtual/pkgconfig"

PATCHES=(
	"${FILESDIR}"/${PV}-include.patch
	"${FILESDIR}"/${PV}-glibc-2.12.patch #333843
	)

src_prepare() {
	base_src_prepare
	# bug 333843
	mv src/endian.h src/bo_endian.h || die
	mv src/endian.c src/bo_endian.c || die
	eautoreconf
}

src_test () {
	Xemake check || die
}

src_install() {
	base_src_install
	if use examples; then
		pushd "${WORKDIR}"/burrow-demos
		docinto demonstration
		dodoc * || die "dodoc demo failed"
		cd data
		docinto demonstration/data
		dodoc * || die "dodoc data failed"
		popd
	fi
}
