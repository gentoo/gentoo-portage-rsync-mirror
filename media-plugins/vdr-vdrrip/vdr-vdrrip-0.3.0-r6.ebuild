# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-vdrrip/vdr-vdrrip-0.3.0-r6.ebuild,v 1.3 2007/04/28 16:38:44 swegener Exp $

inherit vdr-plugin eutils

DESCRIPTION="VDR plugin: convert video-recordings to mpeg4 for burning on CDs"
HOMEPAGE="http://www.a-land.de/"
SRC_URI="http://www.a-land.de/${P}.tgz
		http://www.a-land.de/queuehandler-fixed-0.3.0.sh"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=media-video/vdr-1.2.0"
RDEPEND="${DEPEND}
		>=media-video/mplayer-1.0_pre8
		sys-process/procps
		sys-apps/util-linux"
# media-video/vdrsync seems to be optional

src_unpack() {
	vdr-plugin_src_unpack
	cp ${DISTDIR}/queuehandler-fixed-0.3.0.sh ${S}/scripts/queuehandler.sh

	if
	has_version ">=media-video/vdr-1.3.7" ;
	then
		elog "applying VDR > 1.3.6 patch"
		epatch ${FILESDIR}/vdrrip-0.3.0-1.3.7.diff
		epatch ${FILESDIR}/maketempdir.diff
		epatch ${FILESDIR}/greppid2.diff
		epatch ${FILESDIR}/detectlength.diff
		epatch ${FILESDIR}/fix-ogm-ac3-vdrsync-dev.diff
		epatch ${FILESDIR}/fixpreview.diff
		epatch ${FILESDIR}/mencoderparam-2.diff
		epatch ${FILESDIR}/preserve-queue-owner.diff
		epatch ${FILESDIR}/log-patch.diff
		epatch ${FILESDIR}/vdr-vdrrip-0.3.0-mplayercmd2.diff
	fi

	elog "Patching queuehandler.sh.conf for gentoo-needs..."
	cd ${S}
	sed -e "s,/usr/local/bin/,/usr/bin/," \
		-e 's,/usr/bin/mencoder_ac3,/usr/bin/mencoder,' \
		-e 's,/usr/bin/mplayer_ac3,/usr/bin/mplayer,' \
		-i scripts/queuehandler.sh.conf

	sed -e 's,scriptdir=`dirname $0`,scriptdir=/etc/vdr/plugins/vdrrip,' \
		-e 's,nice -+19,nice -n 19,' \
		-i scripts/queuehandler.sh
}

src_install() {
	vdr-plugin_src_install

	# save config files
	insinto /etc/vdr/plugins/vdrrip
	newins scripts/queuehandler.sh.conf vdrrip-qh.conf
	newconfd ${FILESDIR}/vdrrip-qh.conf vdrrip-qh
	# add start script
	doinitd ${FILESDIR}/vdrrip-qh
	# save in bin
	newbin scripts/queuehandler.sh vdrrip-qh
}

pkg_postinst() {
	vdr-plugin_pkg_postinst

	elog "You should have a look at this files:"
	elog
	elog "* /etc/vdr/plugins/vdrrip/vdrrip-qh.conf"
	elog
	elog "Use vdrrip-qh to start the vdrrip queue handler."
	elog "You can also run 'rc-update add /etc/init.d/vdrrip-qh default' to"
	elog "let vdrrip-qh start automaticly when the system starts."

	elog
	elog "If you used vdrrip before, mind that it runs by default as user vdr now."
	elog "To correct the permissions you should execute this:"
	elog "# chown vdr:vdr -R /var/log/vdrrip-qh /tmp/vdrrip /tmp/queuehandler.vdr"
	elog
}
