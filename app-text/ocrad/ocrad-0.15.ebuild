# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/ocrad/ocrad-0.15.ebuild,v 1.8 2010/07/21 19:39:22 ssuominen Exp $

inherit toolchain-funcs eutils

IUSE=""

DESCRIPTION="GNU Ocrad is an OCR (Optical Character Recognition) program"

SRC_URI="http://savannah.nongnu.org/download/ocrad/${P}.tar.bz2"
HOMEPAGE="http://www.gnu.org/software/ocrad/ocrad.html"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ppc ~ppc64 sparc ~x86"

DEPEND=""

src_compile() {
	# econf doesn't work (unrecognized option --host)
	./configure --prefix=/usr || die
	emake CXX="$(tc-getCXX)" CXXFLAGS="${CXXFLAGS}" || die
}

src_install() {
	make DESTDIR="${D}" install || die

	doman doc/ocrad.1
	dodoc NEWS TODO README
	insinto /usr/share/doc/${PF}
	doins -r examples
}
