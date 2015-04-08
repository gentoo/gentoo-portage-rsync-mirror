# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/nagtrap/nagtrap-0.1.3.ebuild,v 1.2 2009/02/23 20:41:43 dertobi123 Exp $

EAPI=2

inherit eutils depend.php multilib

DESCRIPTION="NagTrap is an integrated snmptt visualization addon for the Nagios monitoring system"
HOMEPAGE="http://www.nagtrap.org/"
SRC_URI="http://www.nagiosforge.org/gf/download/frsrelease/126/252/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND=""
RDEPEND="dev-lang/php[mysql]
		net-analyzer/snmptt[mysql]
		net-analyzer/nagios-core"

need_php_httpd

src_install() {
	dodoc ChangeLog THANKS

	dodir /usr/share/nagtrap
	cp -r {db,nagtrap} "${D}"/usr/share/nagtrap/
	fperms 640 "${D}"/usr/share/nagtrap/nagtrap/etc/config.ini.php-dist

	sed -i -e 's#use lib.*#use lib "/usr/lib/nagios/plugins";#g' \
	  plugin/check_snmptraps.pl || die "sed failed"

	insinto /usr/$(get_libdir)/nagios/plugins
	insopts -m 750 -g nagios
	doins plugin/check_snmptraps.pl
}
pkg_postinst() {
	elog "Before running NagTrap for the first time, you will need setup its configuration"
	elog "/usr/share/nagtrap/nagtrap/etc/config.ini.php"
	elog "A sample is installed in"
	elog "/usr/share/nagtrap/nagtrap/etc/config.ini.php-sample"
	elog
	elog "NagTrap requires snmptt to write traps into a MySQL database."
	elog "A database schema is available in {$D}usr/share/nagtrap/db"
}
