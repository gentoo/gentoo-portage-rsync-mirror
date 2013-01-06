# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-misc/fitsverify/fitsverify-20110304.ebuild,v 1.3 2012/08/05 14:11:38 bicatali Exp $

EAPI=4
inherit toolchain-funcs

DESCRIPTION="FITS file format checker"
HOMEPAGE="http://heasarc.gsfc.nasa.gov/docs/software/ftools/fitsverify/"
SRC_URI="${HOMEPAGE}/${PN}.tar -> ${P}.tar"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE=""

RDEPEND=">=sci-libs/cfitsio-3"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

S="${WORKDIR}/${PN}"

src_compile() {
	$(tc-getCC) -DSTANDALONE ${CFLAGS} ${LDFLAGS} $(pkg-config --cflags cfitsio) \
		ftverify.c fvrf*.c \
		$(pkg-config --libs cfitsio) -o ${PN} || die "compiled failed"
}

src_install() {
	dobin fitsverify
	dodoc README
}
