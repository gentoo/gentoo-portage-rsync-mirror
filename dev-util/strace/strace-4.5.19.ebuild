# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/strace/strace-4.5.19.ebuild,v 1.14 2010/08/30 18:11:18 vapier Exp $

inherit flag-o-matic

DESCRIPTION="A useful diagnostic, instructional, and debugging tool"
HOMEPAGE="http://sourceforge.net/projects/strace/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh sparc x86 ~amd64-linux ~ia64-linux ~x86-linux"
IUSE="static aio"

# strace only uses the header from libaio
DEPEND="aio? ( >=dev-libs/libaio-0.3.106 )"
RDEPEND=""

src_compile() {
	filter-lfs-flags # configure handles this sanely
	use static && append-ldflags -static

	use aio || export ac_cv_header_libaio_h=no #
	econf || die
	emake || die
}

src_install() {
	emake install DESTDIR="${D}" || die
	dodoc ChangeLog CREDITS NEWS PORTING README* TODO
}
