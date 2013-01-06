# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/cksfv/cksfv-1.3.14.ebuild,v 1.2 2011/04/10 22:49:46 abcd Exp $

EAPI=3
inherit toolchain-funcs

DESCRIPTION="SFV checksum utility (simple file verification)"
HOMEPAGE="http://zakalwe.fi/~shd/foss/cksfv/"
SRC_URI="http://zakalwe.fi/~shd/foss/cksfv/files/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~sparc ~x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~ia64-linux ~x86-linux"
IUSE=""

DEPEND=""

src_configure() {
	# note: not an autoconf configure script
	./configure \
		--compiler=$(tc-getCC) \
		--prefix="${EPREFIX}"/usr \
		--package-prefix="${D}" \
		--bindir="${EPREFIX}"/usr/bin \
		--mandir="${EPREFIX}"/usr/share/man || die
}

src_install() {
	emake install || die
	dodoc ChangeLog README TODO
}
