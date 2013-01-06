# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/mplayer-sh/mplayer-sh-0.8.7.ebuild,v 1.4 2007/11/27 11:48:52 zzam Exp $

inherit eutils

DESCRIPTION="Video Disk Recorder Mplayer API Script"
HOMEPAGE="http://batleth.sapienti-sat.org/projects/VDR/"
SRC_URI="http://batleth.sapienti-sat.org/projects/VDR/versions/mplayer.sh-${PV}.tar.gz"

KEYWORDS="x86 ~amd64"
SLOT="0"
LICENSE="as-is"
IUSE=""

RDEPEND=">=media-video/mplayer-0.1.20070321"

S=${WORKDIR}

src_unpack() {

	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/${P}-parameter-aid.diff"

	sed -i "s:^declare CFGFIL.*$:declare CFGFIL=\"\/etc\/vdr\/plugins\/mplayer\/mplayer.sh.conf\":"  mplayer.sh
	sed -i mplayer.sh.conf -e "s:^LIRCRC.*$:LIRCRC=\/etc\/lircd.conf:" \
		-e "s:^MPLAYER=.*$:MPLAYER=\/usr\/bin\/mplayer:"
}

src_install() {

	insinto /etc/vdr/plugins/mplayer
	doins mplayer.sh.conf

	into /usr/share/vdr/mplayer
	dobin mplayer.sh

	dodir /etc/vdr/plugins/DVD-VCD
	touch "${D}"/etc/vdr/plugins/DVD-VCD/{DVD,VCD}
	fowners vdr:vdr /etc/vdr/plugins/DVD-VCD/{DVD,VCD}
}
