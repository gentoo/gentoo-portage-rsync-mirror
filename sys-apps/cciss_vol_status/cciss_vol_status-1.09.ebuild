# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/cciss_vol_status/cciss_vol_status-1.09.ebuild,v 1.1 2011/05/27 09:32:46 chainsaw Exp $

EAPI=4

IUSE=""
DESCRIPTION="Shows status of logical drives attached to HP SmartArray controllers."
HOMEPAGE="http://cciss.sourceforge.net/#cciss_utils"
LICENSE="GPL-2"
SRC_URI="mirror://sourceforge/cciss/${P}.tar.gz"
KEYWORDS="~amd64 ~x86"
SLOT="0"
RDEPEND=""
DEPEND=""

src_install() {
	emake DESTDIR="${D}" install || die "Install failed."
	dodoc AUTHORS ChangeLog NEWS README
}
