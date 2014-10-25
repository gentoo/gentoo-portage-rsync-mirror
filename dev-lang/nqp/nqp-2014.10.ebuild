# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/nqp/nqp-2014.10.ebuild,v 1.1 2014/10/25 03:13:27 patrick Exp $

EAPI=5

inherit eutils multilib

# hrm, doesn't look happy
RESTRICT="test"

GITCRAP=e69a814
PARROT_VERSION="6.7.0"

DESCRIPTION="Not Quite Perl, a Perl 6 bootstrapping compiler"
HOMEPAGE="http://rakudo.org/"
SRC_URI="http://github.com/perl6/${PN}/tarball/${PV} -> ${P}.tar.gz"

LICENSE="Artistic-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="doc +parrot java moar"
REQUIRED_USE="|| ( parrot java moar )"

RDEPEND="parrot? ( >=dev-lang/parrot-${PARROT_VERSION}:=[unicode] )
	java? ( >=virtual/jre-1.7 )
	moar? ( =dev-lang/moarvm-${PV} )"
DEPEND="${RDEPEND}
	java? ( >=virtual/jdk-1.7 )
	dev-lang/perl"

S=${WORKDIR}/perl6-nqp-${GITCRAP}

src_configure() {
	use java && myconf+="jvm,"
	use parrot && myconf+="parrot,"
	use moar && myconf+="moar,"
	perl Configure.pl --backend=${myconf} --prefix=/usr || die
	# dirty hack to make dyncall not fail
	sed -i -e 's/-Werror=missing-prototypes//' Makefile || die
	sed -i -e 's/-Werror=missing-declarations//' Makefile || die
	sed -i -e 's/-Werror=strict-prototypes//' Makefile || die
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
