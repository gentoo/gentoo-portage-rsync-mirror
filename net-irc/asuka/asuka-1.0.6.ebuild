# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/asuka/asuka-1.0.6.ebuild,v 1.16 2014/01/08 06:34:55 vapier Exp $

inherit eutils user

DESCRIPTION="The QuakeNet IRC Server"
HOMEPAGE="http://dev-com.quakenet.org/"
SRC_URI="http://dev-com.quakenet.org/releases/${PN}/${PV}/${P}.tar.bz2"

LICENSE="GPL-1"
SLOT="0"
KEYWORDS="x86 sparc ~ppc"

IUSE="debug"
DEPEND=""

src_compile() {
	econf \
		--with-symlink=asuka-ircd \
		--with-dpath=/etc/asuka \
		--with-cpath=/etc/asuka/ircd.conf \
		--with-lpath=/var/log/asuka/asuka.log \
		$(use_enable debug) \
		|| die "econf failed"
	emake || die "emake failed"
}

src_install() {
	newbin ircd/ircd asuka-ircd

	newman doc/ircd.8 asuka-ircd.8

	insinto /etc/asuka
	doins doc/ircd.conf.sample

	newinitd ${FILESDIR}/asuka.init.d asuka

	newconfd ${FILESDIR}/asuka.conf.d asuka

	keepdir /var/log/asuka

	dodoc INSTALL* LICENSE README* RELEASE.NOTES TODO* \
		doc/readme.* doc/p10.html doc/features.txt doc/Authors
}

pkg_postinst() {
	enewuser asuka
	chown asuka ${ROOT}/var/log/asuka

	elog
	elog "A sample config file can be found at /etc/asuka/ircd.conf.sample"
	elog
}
