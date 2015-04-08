# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/nagircbot/nagircbot-0.0.27.ebuild,v 1.2 2008/05/21 19:56:58 dertobi123 Exp $

DESCRIPTION="An irc bot that alerts you to nagios changes"
HOMEPAGE="http://www.vanheusden.com/nagircbot"
SRC_URI="http://www.vanheusden.com/nagircbot/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND="net-analyzer/nagios-core"

src_install() {
	dodir /usr/bin
	cp "${S}"/nagircbot "${D}"/usr/bin

	dodir /etc/init.d
	dodir /etc/conf.d
	cp "${FILESDIR}"/conf "${D}"/etc/conf.d/nagircbot
	cp "${FILESDIR}"/init "${D}"/etc/init.d/nagircbot
}
