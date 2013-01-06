# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/nagircbot/nagircbot-0.0.33.ebuild,v 1.2 2012/05/04 06:08:10 jdhore Exp $

EAPI=4

inherit toolchain-funcs

DESCRIPTION="An irc bot that alerts you to nagios changes"
HOMEPAGE="http://www.vanheusden.com/nagircbot"
SRC_URI="http://www.vanheusden.com/nagircbot/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

CDEPEND="dev-libs/openssl"
DEPEND="virtual/pkgconfig
	${CDEPEND}"
RDEPEND="net-analyzer/nagios-core
	${CDEPEND}"

src_prepare() {
cp -av Makefile{,.org}
	sed -i Makefile \
		-e 's:-lcrypto -lssl:$(shell pkg-config --libs openssl):g' \
		-e 's:-O2::g;s:-g::g' \
		|| die
}

src_compile() {
	emake CC=$(tc-getCC) CXX=$(tc-getCXX)
}

src_install() {
	dodir /usr/bin
	cp "${S}"/nagircbot "${D}"/usr/bin

	dodir /etc/init.d
	dodir /etc/conf.d
	cp "${FILESDIR}"/conf "${D}"/etc/conf.d/nagircbot
	cp "${FILESDIR}"/init "${D}"/etc/init.d/nagircbot
}
