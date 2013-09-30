# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/novnc/novnc-0.4.ebuild,v 1.2 2013/09/30 14:41:39 prometheanfire Exp $

EAPI=5

DESCRIPTION="noVNC is a VNC client implemented using HTML5 technologies."
HOMEPAGE="http://kanaka.github.com/noVNC/"
SRC_URI="https://github.com/kanaka/noVNC/archive/v${PV}.tar.gz"
S="${WORKDIR}/noVNC-${PV}"

LICENSE="MPL-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="nova"

DEPEND=""
RDEPEND="${DEPEND}
		dev-python/websockify
		dev-python/matplotlib
		dev-python/numpy
		nova? ( sys-cluster/nova )"

src_install() {
	dodir /usr/share/novnc
	insinto /usr/share/novnc
	doins -r *.html images include
	dodoc README.md

	newconfd "${FILESDIR}/noVNC.confd" noVNC
	newinitd "${FILESDIR}/noVNC.initd" noVNC

	diropts -m 0750
	dodir /var/log/noVNC
}
