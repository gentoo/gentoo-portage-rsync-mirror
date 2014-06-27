# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/nqp/nqp-2014.06.ebuild,v 1.1 2014/06/27 07:00:03 patrick Exp $

EAPI=5

inherit eutils multilib

GITCRAP=7792847

DESCRIPTION="Not Quite Perl, a Perl 6 bootstrapping compiler"
HOMEPAGE="http://rakudo.org/"
SRC_URI="http://github.com/perl6/${PN}/tarball/${PV} -> ${P}.tar.gz"

LICENSE="Artistic-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
#IUSE="doc +parrot java moar"
# doesn't build with parrot, disable temporarily
IUSE="doc java +moar"
REQUIRED_USE="|| ( java moar )"

RDEPEND="java? ( >=virtual/jre-1.7 )
	moar? ( =dev-lang/moarvm-${PV} )"
DEPEND="${RDEPEND}
	java? ( >=virtual/jdk-1.7 )
	dev-lang/perl"

S=${WORKDIR}/perl6-nqp-${GITCRAP}

src_configure() {
	use java && myconf+="jvm,"
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
