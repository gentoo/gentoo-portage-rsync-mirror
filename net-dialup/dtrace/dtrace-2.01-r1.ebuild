# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/dtrace/dtrace-2.01-r1.ebuild,v 1.2 2010/05/07 12:17:02 sbriesen Exp $

EAPI="2"

inherit eutils

DESCRIPTION="DTRACE traces ISDN messages with AVM ISDN-controllers"
HOMEPAGE="ftp://ftp.avm.de/develper/d3trace/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~x86 -*"
IUSE=""

RDEPEND="net-dialup/capi4k-utils"

S="${WORKDIR}/develper/d3trace/linux"

src_prepare() {
	edos2unix readme.txt
}

src_install() {
	exeinto /opt/bin
	newexe dtrace.static dtrace-avm
	newdoc readme.txt README
}
