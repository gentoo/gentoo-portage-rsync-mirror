# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-doc/linkers-and-loaders/linkers-and-loaders-1.ebuild,v 1.6 2013/04/01 13:03:54 ulm Exp $

DESCRIPTION="the Linkers and Loaders book"
HOMEPAGE="http://linker.iecc.com/"
SRC_URI="http://wh0rd.org/${P}.tar.lzma"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh sparc x86 ~amd64-linux ~x86-linux ~ppc-macos"
IUSE="doc"
RESTRICT="mirror bindist"

RDEPEND=""
DEPEND="app-arch/xz-utils"

S=${WORKDIR}

src_install() {
	dohtml *.html *.jpg || die
	dodoc *.pdf
	use doc && dodoc *.txt *.rtf
}
