# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/mysql-init-scripts/mysql-init-scripts-2.1_alpha2.ebuild,v 1.1 2015/05/27 17:02:26 grknight Exp $

EAPI=5

inherit systemd

DESCRIPTION="Gentoo MySQL init scripts."
HOMEPAGE="http://www.gentoo.org/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~sparc-fbsd ~x86-fbsd"
IUSE="s6"

DEPEND=""
# This _will_ break with MySQL 5.0, 4.x, 3.x
# It also NEEDS openrc for the save_options/get_options builtins.
RDEPEND="
	!<dev-db/mysql-5.1
	s6? ( >=sys-apps/openrc-0.16.2 sys-apps/s6 )
	"
# Need to set S due to PMS saying we need it existing, but no SRC_URI
S=${WORKDIR}

src_install() {
	newconfd "${FILESDIR}/conf.d-2.0" "mysql"
	if use s6 ; then
		newinitd "${FILESDIR}/init.d-s6" "mysql"
		exeinto /var/svc.d/mysql
		newexe "${FILESDIR}/run-s6" "run"
		exeinto /var/svc.d/mysql/log
		newexe "${FILESDIR}/log-s6" "run"
	else
		newinitd "${FILESDIR}/init.d-2.0" "mysql"
	fi

	# systemd unit installation
	exeinto /usr/libexec
	doexe "${FILESDIR}"/mysqld-wait-ready
	systemd_dounit "${FILESDIR}/mysqld.service"
	systemd_newunit "${FILESDIR}/mysqld_at.service" "mysqld@.service"
	systemd_dotmpfilesd "${FILESDIR}/mysql.conf"

	insinto /etc/logrotate.d
	newins "${FILESDIR}/logrotate.mysql" "mysql"
}

pkg_postinst() {
	if use s6 ; then
		einfo "If you wish to use s6 logging support, "
		einfo "comment out the log-error setting in your my.cnf"
	fi
}
