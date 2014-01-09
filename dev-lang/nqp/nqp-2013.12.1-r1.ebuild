# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/nqp/nqp-2013.12.1-r1.ebuild,v 1.1 2014/01/09 09:06:59 patrick Exp $

EAPI=5

inherit eutils multilib

# MoarVM isn't reliable enough yet

# upstream knows about test fail
RESTRICT="test"

GITCRAP=52dd202
PARROT_VERSION="5.9.0"

DESCRIPTION="Not Quite Perl, a Perl 6 bootstrapping compiler"
HOMEPAGE="http://rakudo.org/"
SRC_URI="http://github.com/perl6/${PN}/tarball/${PV} -> ${P}.tar.gz"

LICENSE="Artistic-2"
SLOT="0"
KEYWORDS=""
IUSE="doc +parrot java moar"
REQUIRED_USE="|| ( parrot java moar )"

RDEPEND="parrot? ( >=dev-lang/parrot-${PARROT_VERSION}[unicode] )
	java? ( virtual/jre )
	moar? ( =dev-lang/moarvm-9999 )"
DEPEND="${RDEPEND}
	java? ( virtual/jdk )
	dev-lang/perl"

S=${WORKDIR}/perl6-nqp-${GITCRAP}

src_configure() {
	use java && myconf+="jvm,"
	use parrot && myconf+="parrot,"
	use moar && myconf+="moar,"
	perl Configure.pl --backend=${myconf} --prefix=/usr || die
}

src_compile() {
	emake -j1 || die
}

src_test() {
	emake -j1 test || die
}

src_install() {
	emake DESTDIR="${ED}" install || die

	dodoc CREDITS README.pod || die

	if use doc; then
		dodoc -r docs/* || die
	fi
}
