# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/dvbsnoop/dvbsnoop-1.4.50-r1.ebuild,v 1.1 2013/09/14 12:58:33 zzam Exp $

EAPI=5

inherit eutils

DESCRIPTION="DVB/MPEG stream analyzer program"
SRC_URI="mirror://sourceforge/dvbsnoop/${P}.tar.gz"
HOMEPAGE="http://dvbsnoop.sourceforge.net/"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~x86"
DEPEND="virtual/linuxtv-dvb-headers"

RDEPEND=""
SLOT="0"
IUSE=""

src_prepare () {
	epatch "${FILESDIR}/${P}-crc32.patch"
}

src_install () {
	emake DESTDIR="${D}" install || die "emake install failed"

	dodoc AUTHORS ChangeLog README
}
