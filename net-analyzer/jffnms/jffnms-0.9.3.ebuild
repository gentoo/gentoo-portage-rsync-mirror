# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/jffnms/jffnms-0.9.3.ebuild,v 1.1 2012/06/12 07:59:04 mabi Exp $

EAPI=4

inherit depend.apache eutils user

DESCRIPTION="Network Management and Monitoring System."
HOMEPAGE="http://www.jffnms.org/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="mysql postgres snmp"

DEPEND="net-analyzer/rrdtool
	media-libs/gd
	dev-lang/php[cli,gd,mysql?,postgres?,session,snmp,sockets,wddx]
	dev-php/PEAR-PEAR
	net-analyzer/net-snmp
	sys-apps/diffutils
	app-mobilephone/smsclient"

RDEPEND="${DEPEND}
	media-gfx/graphviz
	net-analyzer/nmap
	net-analyzer/fping"

need_apache

pkg_setup() {
	enewgroup jffnms
	enewuser jffnms -1 /bin/bash -1 jffnms,apache
}

src_install(){
	INSTALL_DIR="/opt/${PN}"
	IMAGE_DIR="${D}${INSTALL_DIR}"

	dodir "${INSTALL_DIR}"
	cp -r * "${IMAGE_DIR}" || die
	rm -f "${IMAGE_DIR}/LICENSE"

	# Clean up windows related stuff
	rm -f "${IMAGE_DIR}/*.win32.txt"
	rm -rf "${IMAGE_DIR}/docs/windows"
	rm -rf "${IMAGE_DIR}/engine/windows"

	chown -R jffnms:apache "${IMAGE_DIR}" || die
	chmod -R ug+rw "${IMAGE_DIR}" || die

	elog "${PN} has been partialy installed on your system. However you"
	elog "still need proceed with final installation and configuration."
	elog "You can visit http://www.gentoo.org/doc/en/jffnms.xml in order"
	elog "to get detailed information on how to get jffnms up and running."
}
