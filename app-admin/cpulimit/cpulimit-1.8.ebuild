# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/cpulimit/cpulimit-1.8.ebuild,v 1.1 2012/12/30 13:45:46 ago Exp $

EAPI=5

inherit toolchain-funcs

DESCRIPTION="Limits the CPU usage of a process"
HOMEPAGE="http://cpulimit.sourceforge.net"
SRC_URI="mirror://sourceforge/limitcpu/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

src_prepare() {
	tc-export CC
}

src_install() {
	dosbin ${PN}
	doman "${FILESDIR}/${PN}.8"
}
