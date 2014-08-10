# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/dvbackup/dvbackup-0.0.4.ebuild,v 1.3 2014/08/10 20:58:03 slyfox Exp $

DESCRIPTION="A small utility for creating backups on DV tapes"
HOMEPAGE="http://dvbackup.sourceforge.net/"
SRC_URI="http://belnet.dl.sourceforge.net/sourceforge/dvbackup/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE=""

DEPEND="sys-libs/glibc"

src_compile() {
	emake || die "emake failed"
}

src_install() {
	dobin dvconnect
	dobin dvbackup
	dodoc AUTHORS ChangeLog ReleaseNotes dvbackup.html
}
