# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/nawk/nawk-20110810-r1.ebuild,v 1.3 2012/10/12 22:04:36 naota Exp $

EAPI="4"

inherit toolchain-funcs

DESCRIPTION="Brian Kernighan's pattern scanning and processing language"
HOMEPAGE="http://cm.bell-labs.com/cm/cs/awkbook/index.html"
SRC_URI="http://www.cs.princeton.edu/~bwk/btl.mirror/awk.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~x86-fbsd ~amd64-linux ~x86-macos"
IUSE=""

RDEPEND="app-admin/eselect-awk"
DEPEND="${RDEPEND}
	virtual/yacc"

S="${WORKDIR}"

src_compile() {
	emake CC="$(tc-getCC)" CFLAGS="${CFLAGS}" ALLOC="${LDFLAGS}" YACC=$(type -p yacc)
}

src_install() {
	newbin a.out "${PN}"
	sed -e 's/awk/nawk/g' \
		-e 's/AWK/NAWK/g' \
		-e 's/Awk/Nawk/g' \
		awk.1 > "${PN}".1 || die "manpage patch failed"
	doman "${PN}".1
	dodoc README FIXES
}

pkg_postinst() {
	eselect awk update ifunset
}

pkg_postrm() {
	eselect awk update ifunset
}
