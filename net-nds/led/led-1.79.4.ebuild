# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-nds/led/led-1.79.4.ebuild,v 1.5 2007/02/17 08:36:53 robbat2 Exp $

inherit eutils
DESCRIPTION="led is a general purpose LDAP editor"
HOMEPAGE="http://led.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc"
IUSE=""

DEPEND=">=dev-lang/perl-5.6.1
	dev-perl/perl-ldap
	dev-perl/URI
	virtual/perl-Digest-MD5
	dev-perl/Authen-SASL"

src_compile() {
	# non-standard configure system!
	perl Configure --prefix=/usr --generic --rfc2307 --shadow --local --iplanet
	# parallel make bad
	emake -j1
}

src_install() {
	dobin ldapcat
	newbin led.pl led # this is weird I know, read the generated Makefile to see why...
	dodoc INSTALL README README.ldapcat TODO
}
