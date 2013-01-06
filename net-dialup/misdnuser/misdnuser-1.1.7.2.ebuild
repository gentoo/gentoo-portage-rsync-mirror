# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/misdnuser/misdnuser-1.1.7.2.ebuild,v 1.1 2008/02/12 08:14:18 sbriesen Exp $

inherit eutils toolchain-funcs

MY_P="mISDNuser-${PV//./_}"

DESCRIPTION="mISDN (modular ISDN) kernel link library and includes"
HOMEPAGE="http://www.mISDN.org"
SRC_URI="http://www.misdn.org/downloads/releases/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=net-dialup/misdn-1.1.7.2
	sys-libs/ncurses"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	#epatch "${FILESDIR}/misdnuser-as-needed.patch"
	sed -i -e "s:^\(ifeq\):#\1:g" -e "s:^\(endif\):#\1:g" \
		-e "s/\(CFLAGS\):/\1+/g" Makefile
}

src_compile() {
	emake -j1 CC="$(tc-getCC)" MISDNDIR="/usr"
}

src_install() {
	emake INSTALL_PREFIX="${D}" install || die "emake install failed"
	dodoc CHANGES doc/*
}
