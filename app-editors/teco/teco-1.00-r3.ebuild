# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/teco/teco-1.00-r3.ebuild,v 1.14 2013/02/28 17:56:16 ulm Exp $

EAPI=3

inherit eutils toolchain-funcs flag-o-matic

DESCRIPTION="Classic TECO editor, Predecessor to EMACS"
HOMEPAGE="http://www.ibiblio.org/pub/linux/apps/editors/tty/ http://www.ibiblio.org/pub/academic/computer-science/history/pdp-11/teco"
SRC_URI="http://www.ibiblio.org/pub/linux/apps/editors/tty/teco.tar.gz
	doc? ( mirror://gentoo/tecolore.txt.gz
		mirror://gentoo/tech.txt.gz
		mirror://gentoo/teco.doc.gz
		mirror://gentoo/tecoprog.doc.gz )"

LICENSE="freedist"
SLOT="0"
KEYWORDS="alpha ~amd64 ~ppc x86 ~amd64-linux ~x86-linux ~ppc-macos ~sparc-solaris ~x86-solaris"
IUSE="doc"

RDEPEND="sys-libs/ncurses"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

S=${WORKDIR}

src_unpack() {
	unpack teco.tar.gz
	if use doc; then
		mkdir doc
		cd doc || die
		unpack tecolore.txt.gz tech.txt.gz teco.doc.gz tecoprog.doc.gz
	fi
}

src_prepare() {
	local pkg_config=$("$(tc-getPKG_CONFIG)" --libs ncurses)
	sed -i -e "s:\$(CC):& \$(LDFLAGS):;s:-ltermcap:${pkg_config}:" \
		Makefile || die
	# bug 103257
	epatch "${FILESDIR}"/${PN}-double-free.diff
	epatch "${FILESDIR}"/${PN}-gcc4.patch
}

src_compile() {
	append-flags -ansi
	append-cppflags -D_POSIX_SOURCE
	emake CC="$(tc-getCC)" CFLAGS="${CFLAGS}" || die
}

src_install() {
	dobin te || die
	doman te.1 || die
	dodoc sample.tecorc sample.tecorc2 READ.ME MANIFEST || die
	if use doc; then
		cd doc
		dodoc tecolore.txt tech.txt teco.doc tecoprog.doc || die
	fi
}

pkg_postinst() {
	elog "The TECO binary is called te."
	elog "Sample configurations and documentation is available in /usr/share/doc/"
}
