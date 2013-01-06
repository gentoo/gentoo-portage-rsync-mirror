# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/tree/tree-1.6.0.ebuild,v 1.11 2011/12/29 21:52:30 halcy0n Exp $

EAPI=4
inherit toolchain-funcs flag-o-matic bash-completion-r1

DESCRIPTION="Lists directories recursively, and produces an indented listing of files."
HOMEPAGE="http://mama.indstate.edu/users/ice/tree/"
SRC_URI="ftp://mama.indstate.edu/linux/tree/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc x86"
IUSE=""

src_prepare() {
	sed -i \
		-e 's:LINUX:__linux__:' tree.c \
		|| die "sed failed"
	mv doc/tree.1.fr doc/tree.fr.1
}

src_compile() {
	append-lfs-flags
	emake \
		CC="$(tc-getCC)" \
		CFLAGS="${CFLAGS} ${CPPFLAGS}" \
		LDFLAGS="${LDFLAGS}" \
		XOBJS="$(use elibc_uclibc && echo strverscmp.o)"
}

src_install() {
	dobin tree
	doman doc/tree*.1
	dodoc CHANGES README*
	newbashcomp "${FILESDIR}"/${PN}.bashcomp ${PN}
}
