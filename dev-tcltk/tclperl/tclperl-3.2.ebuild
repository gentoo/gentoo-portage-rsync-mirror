# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tcltk/tclperl/tclperl-3.2.ebuild,v 1.4 2011/05/23 07:16:41 tomka Exp $

inherit flag-o-matic multilib toolchain-funcs

DESCRIPTION="a Perl package for Tcl"
HOMEPAGE="http://jfontain.free.fr/tclperl.htm"
SRC_URI="http://jfontain.free.fr/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE=""

DEPEND=">=dev-lang/tcl-8.3.3
	>=dev-lang/perl-5.6.0"

src_compile() {
	append-flags -fPIC

	# ./build.sh
	perl Makefile.PL || die
	make OPTIMIZE="${CFLAGS}" Tcl.o || die

	$(tc-getCC) -shared ${LDFLAGS} ${CFLAGS} -o tclperl.so.${PV} -DUSE_TCL_STUBS \
		tclperl.c tclthread.c `perl -MExtUtils::Embed -e ccopts -e ldopts` \
		/usr/$(get_libdir)/libtclstub`echo 'puts $tcl_version' | tclsh`.a Tcl.o || die
}

src_install() {
	exeinto /usr/$(get_libdir)/${P}
	doexe tclperl.so.${PV} || die "lib"
	doexe pkgIndex.tcl || die "tcl"

	dodoc CHANGES README
	dohtml tclperl.htm
}
