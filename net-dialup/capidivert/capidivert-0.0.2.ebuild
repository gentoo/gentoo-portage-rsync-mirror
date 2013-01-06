# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/capidivert/capidivert-0.0.2.ebuild,v 1.2 2010/09/30 12:32:05 sbriesen Exp $

DESCRIPTION="CAPI based utility to control ISDN diversion facilities"
HOMEPAGE="http://www.tp1.ruhr-uni-bochum.de/~kai/i4l/capidivert/"
SRC_URI="http://www.tp1.ruhr-uni-bochum.de/~kai/i4l/capidivert/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="net-dialup/capi4k-utils"
RDEPEND="${DEPEND}"

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
}
