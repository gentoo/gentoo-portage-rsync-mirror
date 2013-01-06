# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/ris-linux/ris-linux-0.4.ebuild,v 1.2 2011/08/09 19:17:52 maksbotan Exp $

EAPI=3

PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils python

DESCRIPTION="BINL server to doing Windows(r) RIS"
HOMEPAGE="http://oss.netfarm.it/guides/pxe.php"
SRC_URI="http://oss.netfarm.it/guides/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
	|| ( net-ftp/atftp net-ftp/tftp-hpa )
	net-misc/dhcp
	net-fs/samba
	sys-boot/syslinux"

src_prepare(){
	sed "s:VERSION:${PV}:" "${FILESDIR}"/setup.py > "${S}"/setup.py
	distutils_src_prepare
}

src_install() {
	distutils_src_install

	newinitd "${FILESDIR}"/binlsrv.initd binlsrv
	newconfd "${FILESDIR}"/binlsrv.confd binlsrv
}
