# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/dejagnu/dejagnu-1.4.4-r2.ebuild,v 1.1 2010/03/16 00:24:47 vapier Exp $

inherit eutils

DESCRIPTION="framework for testing other programs"
HOMEPAGE="http://www.gnu.org/software/dejagnu/"
SRC_URI="mirror://gnu/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~sparc-fbsd ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~x86-macos ~x86-solaris"
IUSE="doc"

DEPEND="dev-lang/tcl
	dev-tcltk/expect"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/dejagnu-ignore-libwarning.patch
	epatch "${FILESDIR}"/${P}-rsh-username.patch
}

src_test() {
	# if you dont have dejagnu emerged yet, you cant
	# run the tests ... crazy aint it :)
	type -p runtest || return 0
	emake check || die "check failed :("
}

src_install() {
	emake -j1 install DESTDIR="${D}" || die
	dodoc AUTHORS ChangeLog NEWS README TODO
	use doc && dohtml -r doc/html/
}
