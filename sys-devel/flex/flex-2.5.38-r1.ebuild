# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/flex/flex-2.5.38-r1.ebuild,v 1.1 2014/03/16 05:06:44 vapier Exp $

EAPI="4"

inherit flag-o-matic

DESCRIPTION="The Fast Lexical Analyzer"
HOMEPAGE="http://flex.sourceforge.net/"
SRC_URI="mirror://sourceforge/flex/${P}.tar.xz"

LICENSE="FLEX"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~amd64-fbsd ~sparc-fbsd ~x86-fbsd ~arm-linux ~x86-linux"
IUSE="nls static test"

# We want bison explicitly and not yacc in general #381273
RDEPEND="sys-devel/m4"
DEPEND="${RDEPEND}
	app-arch/xz-utils
	nls? ( sys-devel/gettext )
	test? ( sys-devel/bison )"

src_configure() {
	use static && append-ldflags -static
	# Do not install shared libs #503522
	econf \
		--disable-shared \
		$(use_enable nls) \
		--docdir='$(datarootdir)/doc/'${PF}
}

src_install() {
	default
	dodoc ONEWS
	find "${ED}" -name '*.la' -delete
	rm "${ED}"/usr/share/doc/${PF}/{COPYING,flex.pdf} || die
	dosym flex /usr/bin/lex
}
