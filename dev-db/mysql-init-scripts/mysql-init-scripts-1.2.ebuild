# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/mysql-init-scripts/mysql-init-scripts-1.2.ebuild,v 1.4 2010/10/19 05:53:42 leio Exp $

DESCRIPTION="Gentoo MySQL init scripts."
HOMEPAGE="http://www.gentoo.org/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh sparc x86 ~sparc-fbsd ~x86-fbsd"
IUSE=""

DEPEND=""
RDEPEND=""

src_install() {
	newconfd "${FILESDIR}/mysql.conf.d" "mysql"
	newconfd "${FILESDIR}/mysqlmanager.conf.d" "mysqlmanager"

	newinitd "${FILESDIR}/mysql.rc6" "mysql"
	newinitd "${FILESDIR}/mysqlmanager.rc6" "mysqlmanager"

	insinto /etc/logrotate.d
	newins "${FILESDIR}/logrotate.mysql" "mysql"
}
