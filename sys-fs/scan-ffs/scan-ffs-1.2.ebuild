# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/scan-ffs/scan-ffs-1.2.ebuild,v 1.2 2007/02/22 10:35:36 drizzt Exp $

inherit bsdmk

MY_PN=${PN/-/_}
MY_P=${MY_PN}-${PV}
DESCRIPTION="Recovers lost disklabel"
HOMEPAGE="http://www.ranner.jawa.at/"
SRC_URI="http://www.ranner.jawa.at/stuff/${MY_P}.tar.bz2"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~x86-fbsd"
IUSE=""

DEPEND=""
RDEPEND=""

S="${WORKDIR}/${MY_P}"

src_install() {
	bsdmk_src_install
	dodoc README ChangeLog
}
