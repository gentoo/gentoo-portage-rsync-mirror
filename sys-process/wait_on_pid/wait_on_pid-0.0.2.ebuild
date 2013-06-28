# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-process/wait_on_pid/wait_on_pid-0.0.2.ebuild,v 1.2 2013/06/28 18:51:01 zzam Exp $

EAPI="5"

inherit eutils toolchain-funcs

DESCRIPTION="small utility to wait for an arbitrary process to exit"
HOMEPAGE="http://dev.gentoo.org/~zzam/wait_on_pid/"
SRC_URI="mirror://gentoo/$P.tar.bz2 http://dev.gentoo.org/~zzam/wait_on_pid/$P.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ppc ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

src_prepare() {
	tc-export CC
}

src_install() {
	dobin wait_on_pid || die
	dodoc README
}
