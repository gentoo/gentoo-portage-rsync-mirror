# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/novnc/novnc-0.4.ebuild,v 1.1 2013/09/27 01:39:57 prometheanfire Exp $

EAPI=5

DESCRIPTION="noVNC is a VNC client implemented using HTML5 technologies."
HOMEPAGE="http://kanaka.github.com/noVNC/"
SRC_URI="https://github.com/kanaka/noVNC/archive/v${PV}.tar.gz"
S="${WORKDIR}/noVNC-${PV}"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
		dev-python/numpy"

src_compile() {
	cd "${S}/utils"
	emake
}

src_install() {
	dodir /usr/share/novnc
	dodir /usr/share/novnc/utils
	dodir /usr/share/novnc/include
	dodir /usr/share/novnc/images

	exeinto /usr/share/novnc/utils
	doexe utils/json2graph.py
	doexe utils/launch.sh
	doexe utils/nova-novncproxy
	doexe utils/rebind
	doexe utils/rebind.so
	doexe utils/u2x11
	doexe utils/web.py
	doexe utils/wsproxy.py
	doexe utils/websocket.py

	docinto /usr/share/novnc/docs
	dodoc README.md
	dodoc LICENSE.txt

	dosym /usr/share/novnc/images/favicon.ico /usr/share/novnc/
	cp -pPR "*.html" "${D}/usr/share/novnc/"
	cp -pPR "include/*" "${D}/usr/share/novnc/include"
	cp -pPR "images/*" "${D}/usr/share/novnc/images"

	newconfd "${FILESDIR}/noVNC.confd" noVNC
	newinitd "${FILESDIR}/noVNC.initd" noVNC

	diropts -m 0750
	dodir /var/log/noVNC
}
