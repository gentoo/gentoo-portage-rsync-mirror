# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/elettra/elettra-1.0.ebuild,v 1.2 2011/08/28 10:56:33 hwoarang Exp $

inherit toolchain-funcs

MY_P="${PN}-src-${PV}"

DESCRIPTION="Plausible deniable file cryptography"
HOMEPAGE="http://www.winstonsmith.info/julia/elettra/"
SRC_URI="http://www.winstonsmith.info/julia/elettra/${MY_P}.tar.gz"

LICENSE="WTFPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64"
IUSE=""

RDEPEND="sys-libs/zlib
		 app-crypt/mhash
		 dev-libs/libmcrypt"

DEPEND="${RDEPEND}"

S="${WORKDIR}/${PN}"

src_compile() {
	$(tc-getCC) ${CFLAGS} ${LDFLAGS} -I. src/*.c \
		-lz `libmcrypt-config --cflags --libs` -lmhash \
		-o elettra || die "compilation failed"
}

src_install() {
	dobin elettra || die "dobin failed"
	dodoc README || die "dodoc failed"
}
