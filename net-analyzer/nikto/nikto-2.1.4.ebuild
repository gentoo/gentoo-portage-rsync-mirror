# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/nikto/nikto-2.1.4.ebuild,v 1.2 2013/10/24 13:20:09 zlogene Exp $

EAPI=2

DESCRIPTION="Web Server vulnerability scanner."
HOMEPAGE="http://www.cirt.net/Nikto2"
SRC_URI="http://www.cirt.net/nikto/ARCHIVE/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="ssl"

RDEPEND="dev-lang/perl
	>=net-libs/libwhisker-2.5
		ssl? (
			dev-libs/openssl
			dev-perl/Net-SSLeay
		)"

src_prepare() {
	sed -i -e 's:config.txt:nikto.conf:g' \
			plugins/* || die

	sed -i -e 's:/etc/nikto.conf:/etc/nikto/nikto.conf:' \
		 nikto.pl || die

	sed -i -e 's:# EXECDIR=/usr/local/nikto:EXECDIR=/usr/share/nikto:' \
		 nikto.conf || die

	sed -i -e 's:# use LW2:use LW2:' \
		 nikto.pl || die
	sed -i -e 's:require "$CONFIGFILE{'\''PLUGINDIR'\''}/LW2.pm":# require "$CONFIGFILE{'\''PLUGINDIR'\''}/LW2.pm":' \
		 nikto.pl || die
	rm plugins/LW2.pm || die "removing bundled lib LW2.pm failed"
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

	dodir /usr/share/nikto
	insinto /usr/share/nikto
	doins -r plugins templates || die

	dodoc docs/*.txt || die
	dohtml docs/nikto_manual.html || die
}
