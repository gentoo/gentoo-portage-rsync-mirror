# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/devtodo/devtodo-0.1.20.ebuild,v 1.16 2011/01/04 17:55:28 jlec Exp $

EAPI="3"

inherit autotools eutils bash-completion flag-o-matic

DESCRIPTION="A nice command line todo list for developers"
HOMEPAGE="http://swapoff.org/DevTodo"
SRC_URI="http://swapoff.org/files/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc x86 ~amd64-linux ~x86-linux ~ppc-macos"
IUSE=""

RDEPEND="
	>=sys-libs/ncurses-5.2
	>=sys-libs/readline-4.1"
DEPEND="${RDEPEND}"

src_prepare() {
	epatch \
		"${FILESDIR}/${P}-gentoo.diff" \
		"${FILESDIR}/${P}-gcc43.patch"
	# fix regex.h issue on case-insensitive file-systems #332235
	sed -i -e 's/Regex.h/DTRegex.h/' \
		util/Lexer.h util/Makefile.{am,in} util/Regex.cc || die
	mv util/{,DT}Regex.h || die
	eautoreconf
}

src_configure() {
	replace-flags -O[23] -O1
	econf --sysconfdir="${EPREFIX}/etc/devtodo"
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog QuickStart README doc/scripts.sh \
	doc/scripts.tcsh doc/todorc.example || die "dodoc failed"

	dobashcompletion contrib/${PN}.bash-completion ${PN}
	rm contrib/${PN}.bash-completion
	docinto contrib
	dodoc contrib/* || die
}

pkg_postinst() {
	echo
	elog "Because of a conflict with app-misc/tdl, the tdl symbolic link"
	elog "and manual page have been removed."
	bash-completion_pkg_postinst
}
