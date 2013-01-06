# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/misdnuser/misdnuser-1.1.7.ebuild,v 1.1 2007/11/12 19:16:27 genstef Exp $

inherit eutils

MY_P=mISDNuser-${PV//./_}
DESCRIPTION="mISDN (modular ISDN) kernel link library and includes"
HOMEPAGE="http://www.mISDN.org"
SRC_URI="http://www.misdn.org/downloads/releases/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
S=${WORKDIR}/${MY_P}
RDEPEND=">=net-dialup/misdn-1.0.4
	sys-libs/ncurses"
DEPEND="${RDEPEND}"
MAKEOPTS="${MAKEPOPTS} -j1"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/misdnuser-as-needed.patch
}

src_install() {
	emake INSTALL_PREFIX="${D}" install || die "emake install failed"
}
