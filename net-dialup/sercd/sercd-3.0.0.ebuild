# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/sercd/sercd-3.0.0.ebuild,v 1.1 2009/03/22 12:44:53 mrness Exp $

EAPI="2"

DESCRIPTION="RFC2217-compliant serial port redirector"
SRC_URI="mirror://sourceforge/sercd/${P}.tar.gz"
HOMEPAGE="http://sourceforge.net/projects/sercd"

KEYWORDS="~amd64 ~x86"
SLOT="0"
LICENSE="GPL-2"
IUSE="xinetd"

RDEPEND="xinetd? ( virtual/inetd )"

src_install () {
	einstall || die "einstall failed"

	newinitd "${FILESDIR}"/sercd.initd sercd
	newconfd "${FILESDIR}"/sercd.confd sercd
	if use xinetd ; then
		insinto /etc/xinetd.d
		newins "${FILESDIR}"/sercd.xinetd sercd
	fi

	dodoc AUTHORS README
}
