# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/rakudo/rakudo-2015.03.ebuild,v 1.1 2015/03/20 07:27:36 patrick Exp $

EAPI=5

MY_PV="2015.01"

inherit eutils multilib

DESCRIPTION="A Perl 6 implementation built on the Parrot virtual machine"
HOMEPAGE="http://rakudo.org/"
SRC_URI="http://rakudo.org/downloads/${PN}/${P}.tar.gz"

LICENSE="Artistic-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc java +moar"

RDEPEND=">=dev-lang/nqp-${MY_PV}[java?,moar?]"
DEPEND="${RDEPEND}
	dev-lang/perl"

src_configure() {
	use java && myconf+="jvm,"
	use moar && myconf+="moar,"
	perl Configure.pl --backends=${myconf} --prefix=/usr || die
}

src_test() {
	emake -j1 test || die
}

src_install() {
	emake -j1 DESTDIR="${ED}" install || die

	dodoc CREDITS README.md docs/ChangeLog docs/ROADMAP || die

	if use doc; then
		dohtml -A svg docs/architecture.html docs/architecture.svg || die
		dodoc docs/*.pod || die
		docinto announce
		dodoc docs/announce/* || die
	fi
}
