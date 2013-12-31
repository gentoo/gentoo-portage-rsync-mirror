# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/xtrabackup-bin/xtrabackup-bin-2.1.6.ebuild,v 1.1 2013/12/27 00:44:11 idl0r Exp $

EAPI=5

MY_PN="percona-${PN/-bin}"
MY_PVR="${PV}-702"
MY_P="${MY_PN}-${PV}"
MY_PF="${MY_PN}-${MY_PVR}"

DESCRIPTION="MySQL hot backup software that performs non-blocking backups for
InnoDB and XtraDB databases"
HOMEPAGE="http://www.percona.com/software/percona-xtrabackup"
SRC_URI="
	amd64? (
		http://www.percona.com/downloads/XtraBackup/XtraBackup-${PV}/binary/Linux/x86_64/${MY_PF}-Linux-x86_64.tar.gz -> ${MY_P}-x86_64.tar.gz
	)
	x86? (
		http://www.percona.com/downloads/XtraBackup/XtraBackup-${PV}/binary/Linux/i686/${MY_PF}-Linux-i686.tar.gz -> ${MY_P}-x86_32.tar.gz
	)
"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="dev-libs/libaio
	dev-libs/libgcrypt
	dev-libs/libgpg-error"

if use amd64; then
	S="${WORKDIR}/${MY_P}-Linux-x86_64"
elif use x86; then
	S="${WORKDIR}/${MY_P}-Linux-i686"
fi

src_install() {
	for bin in innobackupex xbcrypt xbstream xtrabackup xtrabackup_55 xtrabackup_56; do
		dobin bin/${bin}
	done
	dosym /usr/bin/innobackupex /usr/bin/innobackupex-1.5.1
}
