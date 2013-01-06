# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/midentd/midentd-2.3.1-r1.ebuild,v 1.6 2006/12/04 02:30:15 vapier Exp $

inherit eutils

DESCRIPTION="ident daemon with masquerading and fake replies support"
HOMEPAGE="http://panorama.sth.ac.at/midentd/"
SRC_URI="http://panorama.sth.ac.at/midentd/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~sparc x86"
IUSE=""

RDEPEND="dev-lang/perl"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${PV}-pidfile.patch
	sed -i \
		-e 's:/usr/local:/usr:' \
		-e 's:service ident:service auth:' \
		-e 's:disable = no:disable = yes:' \
		midentd.xinetd
}

src_install() {
	dosbin midentd midentd.logcycle || die

	insinto /etc/xinetd.d
	newins midentd.xinetd midentd
	newinitd "${FILESDIR}"/midentd.rc midentd
	newconfd "${FILESDIR}"/midentd.conf.d midentd

	dodoc CHANGELOG README

	dodir /var/log
	touch "${D}"/var/log/midentd.log
	fowners nobody:nobody /var/log/midentd.log
}
