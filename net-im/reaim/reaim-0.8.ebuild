# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/reaim/reaim-0.8.ebuild,v 1.6 2009/01/14 04:45:22 vapier Exp $

DESCRIPTION="AIM transport proxy over NAT firewalls"
HOMEPAGE="http://reaim.sourceforge.net/"
SRC_URI="mirror://sourceforge/reaim/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE=""

DEPEND=">=sys-apps/sed-4"
RDEPEND="net-firewall/iptables"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i -e '/gcc/d' Makefile # use implicit rule
}

src_install() {
	dosbin reaim || die
	doman reaim.8
	dodoc html/*
	newinitd "${FILESDIR}"/reaim reaim
}
