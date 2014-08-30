# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/nikto/nikto-2.1.5.ebuild,v 1.2 2014/08/30 18:18:59 monsieurp Exp $
EAPI=5
inherit perl-module

DESCRIPTION="Web Server vulnerability scanner"
HOMEPAGE="http://www.cirt.net/Nikto2"
SRC_URI="http://www.cirt.net/nikto/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc ~sparc ~amd64-linux ~x86-linux ~x86-macos"
IUSE="ssl"

RDEPEND="dev-lang/perl
	>=net-libs/libwhisker-2.5
		ssl? (
			dev-libs/openssl
			dev-perl/Net-SSLeay
		)"

src_prepare() {
	sed -i -e 's:config.txt:nikto.conf:g' plugins/* || die

	sed -i -e 's:/etc/nikto.conf:/etc/nikto/nikto.conf:;
	s:# EXECDIR=/usr/local/nikto:EXECDIR=/usr/share/nikto:;
	s:# use LW2:use LW2:;
	s:require "$CONFIGFILE{'\''PLUGINDIR'\''}/LW2.pm":# require "$CONFIGFILE{'\''PLUGINDIR'\''}/LW2.pm":;' nikto.pl || die
}

src_compile() {
	einfo "nothing to compile"
	true
}

src_install() {
	insinto /etc/nikto
	doins nikto.conf || die "config install failed"

	dobin nikto.pl || die "install failed"
	dosym /usr/bin/nikto.pl /usr/bin/nikto || die

	unset ${NIKTO_PMS}
	dodir /usr/share/nikto
	insinto /usr/share/nikto
	doins -r plugins templates databases || die

	NIKTO_PMS="LW2.pm JSON-PP.pm"
	einfo "symlinking ${NIKTO_PMS} to ${VENDOR_LIB}"
	for pm in ${NIKTO_PMS}; do
		dosym /usr/share/nikto/plugins/${pm} ${VENDOR_LIB}/${pm}
	done
	dodoc docs/*.txt || die
	dohtml docs/nikto_manual.html || die

	insinto ${VENDOR_PERL}
}
