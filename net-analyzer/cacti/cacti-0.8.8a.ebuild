# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/cacti/cacti-0.8.8a.ebuild,v 1.1 2013/04/27 15:08:31 pva Exp $

EAPI="4"

inherit eutils webapp depend.php

# Support for _p* in version.
MY_P=${P/_p*/}
UPSTREAM_PATCHES="snmpv3_priv_proto_none"

DESCRIPTION="Cacti is a complete frontend to rrdtool"
HOMEPAGE="http://www.cacti.net/"
SRC_URI="http://www.cacti.net/downloads/${MY_P}.tar.gz"

# patches
if [[ -n ${UPSTREAM_PATCHES} ]]; then
	for i in ${UPSTREAM_PATCHES}; do
		SRC_URI="${SRC_URI} http://www.cacti.net/downloads/patches/${PV/_p*}/${i}.patch"
	done
fi

LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ppc ~ppc64 ~sparc ~x86"
IUSE="snmp doc"

DEPEND=""

need_httpd

RDEPEND="
	net-analyzer/rrdtool
	dev-php/adodb
	virtual/mysql
	virtual/cron
	dev-lang/php[cli,mysql,xml,session,sockets]
	|| ( <dev-lang/php-5.3[pcre] >=dev-lang/php-5.3 )
	snmp? ( >=net-analyzer/net-snmp-5.1.2 )
"

src_unpack() {
	unpack ${MY_P}.tar.gz
	if [[ -n ${UPSTREAM_PATCHES} ]]; then
		[ ! ${MY_P} == ${P} ] && mv ${MY_P} ${P}
	fi
}

src_prepare() {
	if [[ -n ${UPSTREAM_PATCHES} ]]; then
		for i in ${UPSTREAM_PATCHES} ; do
			EPATCH_OPTS="-p1 -d ${S} -N" epatch "${DISTDIR}"/${i}.patch
		done ;
	fi

	sed -i -e \
		's:$config\["library_path"\] . "/adodb/adodb.inc.php":"adodb/adodb.inc.php":' \
		"${S}"/include/global.php || die

	rm -rf lib/adodb || die # don't use bundled adodb
}

src_compile() { :; }

src_install() {
	webapp_src_preinst

	rm LICENSE README || die
	dodoc docs/{CHANGELOG,CONTRIB,README,txt/manual.txt} || die
	use doc && dohtml -r docs/html/
	rm -rf docs

	edos2unix `find -type f -name '*.php'`

	dodir ${MY_HTDOCSDIR}
	cp -r . "${D}"${MY_HTDOCSDIR}

	webapp_serverowned ${MY_HTDOCSDIR}/rra
	webapp_serverowned ${MY_HTDOCSDIR}/log/cacti.log
	webapp_configfile ${MY_HTDOCSDIR}/include/config.php
	webapp_postinst_txt en "${FILESDIR}"/postinstall-en.txt

	webapp_src_install
}
