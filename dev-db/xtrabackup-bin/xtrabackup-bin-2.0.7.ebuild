# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/xtrabackup-bin/xtrabackup-bin-2.0.7.ebuild,v 1.1 2013/05/11 15:01:26 idl0r Exp $

EAPI=5

MY_PN="percona-${PN/-bin}"
MY_PVR="${PV}-552"
MY_P="${MY_PN}-${PV}"
MY_PF="${MY_PN}-${MY_PVR}"

DESCRIPTION="MySQL hot backup software that performs non-blocking backups for
InnoDB and XtraDB databases"
HOMEPAGE="http://www.percona.com/software/percona-xtrabackup"
SRC_URI="
	amd64? (
		http://www.percona.com/redir/downloads/XtraBackup/XtraBackup-${PV}/binary/Linux/x86_64/${MY_PF}.tar.gz -> ${MY_P}-x86_64.tar.gz
	)
	x86? (
		http://www.percona.com/redir/downloads/XtraBackup/XtraBackup-${PV}/binary/Linux/i686/${MY_PF}.tar.gz -> ${MY_P}-x86_32.tar.gz
	)
"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="dev-libs/libaio"

S="${WORKDIR}/${MY_P}"

src_install() {
	for bin in xtrabackup xtrabackup_55 xbstream xtrabackup_51 innobackupex; do
		dobin bin/${bin}
	done
	dosym /usr/bin/innobackupex /usr/bin/innobackupex-1.5.1
}
