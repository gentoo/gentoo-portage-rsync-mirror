# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/masscan/masscan-1.0.3.ebuild,v 1.1 2014/03/01 21:31:07 robbat2 Exp $

EAPI=5

DESCRIPTION="Mass IP port scanner"
HOMEPAGE="https://github.com/robertdavidgraham/masscan"
SRC_URI="${HOMEPAGE}/archive/${PV}.tar.gz -> ${P}.tar.gz"

SLOT="0"
LICENSE="AGPL-3"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="net-libs/libpcap"
DEPEND="${RDEPEND}"

src_prepare(){
	sed -i \
		-e '/$(CC)/s!$(CFLAGS)!$(LDFLAGS) $(CFLAGS)!g' \
		-e "/^GITVER :=/s!= .(.*!=!g" \
		-e '/$(CC)/s!-DGIT=\"$(GITVER)\"!!g' \
		-e '/^CFLAGS =/{s,=,+=,;s,-g -ggdb,,;s,-O3,,;}' \
		Makefile
}

src_install() {
	emake install DESTDIR="${D}" PREFIX=/usr

	insinto /etc/masscan
	doins data/exclude.conf
	doins "${FILESDIR}"/masscan.conf

	[ -f doc/bot.hml ] && mv doc/bot.{hml,html}
	dohtml doc/bot.html
	doman doc/masscan.8
	dodoc *.md
}
