# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/getdate/getdate-1.2.ebuild,v 1.13 2012/12/08 22:04:41 ulm Exp $

inherit toolchain-funcs

MY_PN=${PN}_rfc868
MY_P=${MY_PN}-${PV}
S=${WORKDIR}/${MY_P}

DESCRIPTION="Network Date/Time Query and Set Local Date/Time Utility"
HOMEPAGE="http://www.ibiblio.org/pub/Linux/system/network/misc/"
SRC_URI="http://www.ibiblio.org/pub/Linux/system/network/misc/${MY_P}.tar.gz"

LICENSE="GPL-1+"
SLOT="0"
KEYWORDS="~amd64 ~mips ppc x86"
IUSE=""

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i -e "/errno.h/ a\#include <string.h>" getdate.c || die
}

src_compile() {
	einfo $(tc-getCC) ${LDFLAGS} ${CFLAGS} -DHAVE_ADJTIME -o getdate getdate.c
	$(tc-getCC) ${LDFLAGS} ${CFLAGS} -DHAVE_ADJTIME -o getdate getdate.c || die
}

src_install() {
	dobin getdate || die
	doman getdate.8 || die
	dodoc README getdate-cron || die
}
