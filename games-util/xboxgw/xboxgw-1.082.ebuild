# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-util/xboxgw/xboxgw-1.082.ebuild,v 1.5 2007/12/05 04:12:52 mr_bones_ Exp $

XBOXGW_P="${PN}-1.08-2"
HMLIBS_P="hmlibs-1.07-2"
DESCRIPTION="Tunnels XBox system link games over the net"
HOMEPAGE="http://www.xboxgw.com/"
SRC_URI="http://www.xboxgw.com/rel/dist2.1/tarballs/i386/${XBOXGW_P}.tgz
	http://www.xboxgw.com/rel/dist2.1/tarballs/i386/${HMLIBS_P}.i386.tgz"

LICENSE="freedist"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE=""

S=${WORKDIR}

src_install() {
	cd "${WORKDIR}/${HMLIBS_P}"
	dolib.so *.so || die
	dobin hmdbdump || die
	insinto /usr/include/hmlibs
	doins *.h || die

	cd "${WORKDIR}/${XBOXGW_P}"
	dobin xboxgw xbifsetup || die
	dodoc *.txt
}
