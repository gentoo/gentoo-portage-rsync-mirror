# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-vcs/tig/tig-1.2.1.ebuild,v 1.3 2013/09/28 19:52:28 ago Exp $

EAPI=5

inherit bash-completion-r1 toolchain-funcs

DESCRIPTION="Tig: text mode interface for git"
HOMEPAGE="http://jonas.nitro.dk/tig/"
SRC_URI="http://jonas.nitro.dk/tig/releases/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd ~x86-freebsd ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"

CDEPEND="sys-libs/ncurses"
DEPEND="${CDEPEND}
	virtual/pkgconfig"
RDEPEND="${CDEPEND}
	dev-vcs/git"

src_prepare() {
	# pre-generated manpages are in the root directory
	sed -i '/^MANDOC/s#doc/##g' Makefile || die
}

src_configure() {
	econf CURSES_LIB="$($(tc-getPKG_CONFIG) --libs ncursesw)"
}

src_compile() {
	# fix version set wrong in tarball
	emake VERSION=${PV}
}

src_install() {
	emake DESTDIR="${D}" install install-doc-man
	dodoc BUGS NEWS
	dohtml manual.html README.html
	newbashcomp contrib/tig-completion.bash ${PN}
}
