# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/snmptt/snmptt-1.3.ebuild,v 1.2 2012/05/12 16:31:50 armin76 Exp $

EAPI="3"

MY_P="${P/-/_}"

DESCRIPTION="SNMP Trap Translator"
SRC_URI="mirror://sourceforge/snmptt/${MY_P}.tgz"
HOMEPAGE="http://www.snmptt.org/"

LICENSE="GPL-2"

KEYWORDS="~amd64 ~ppc ~x86"
SLOT="0"
IUSE="mysql postgres"

S="${WORKDIR}/${MY_P}"

RDEPEND="
	dev-lang/perl
	dev-perl/Config-IniFiles
	net-analyzer/net-snmp
	mysql? ( dev-perl/DBD-mysql )
	postgres? ( dev-perl/DBD-Pg )
"

src_prepare() {
	# bug 105354, daemonize this thing
	sed -i -e "s:mode = standalone:mode = daemon:g" snmptt.ini || die

	echo "traphandle default /usr/sbin/snmptt" >examples/snmptrapd.conf.sample
}

src_install() {
	into /usr
	dosbin snmptt snmptthandler snmptt-net-snmp-test snmpttconvert \
		snmpttconvertmib || die

	insinto /etc/snmp
	doins snmptt.ini examples/snmptt.conf.generic \
		examples/snmptrapd.conf.sample || die
	newins examples/snmptt.conf.generic snmptt.conf || die

	dodoc BUGS ChangeLog README sample-trap
	dohtml docs/faqs.html docs/index.html docs/layout1.css docs/snmptt.html \
		docs/snmpttconvert.html docs/snmpttconvertmib.html || die

	newinitd "${FILESDIR}"/snmptt.initd snmptt || die
}
