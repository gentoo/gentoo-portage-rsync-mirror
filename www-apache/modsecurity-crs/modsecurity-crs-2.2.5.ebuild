# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apache/modsecurity-crs/modsecurity-crs-2.2.5.ebuild,v 1.6 2012/09/09 16:01:47 armin76 Exp $

EAPI=4

DESCRIPTION="Core Rule Set for ModSecurity"
HOMEPAGE="http://www.owasp.org/index.php/Category:OWASP_ModSecurity_Core_Rule_Set_Project"
SRC_URI="mirror://sourceforge/mod-security/${PN}_${PV}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 ppc sparc x86"
IUSE="lua geoip"

RDEPEND=">=www-apache/mod_security-2.5.13-r1[lua?,geoip?]"
DEPEND=""

S="${WORKDIR}/${PN}_${PV}"

RULESDIR=/etc/modsecurity
LUADIR=/usr/share/${PN}/lua

src_prepare() {
	if ! use lua; then
		# comment out this since it's in the same file as another one we want to keep
		sed -i -e "/id:'96000[456]'/s:^:#:" \
			experimental_rules/modsecurity_crs_61_ip_forensics.conf || die

		# remove these that rely on the presence of the lua files
		rm \
			experimental_rules/modsecurity_crs_16_scanner_integration.conf \
			experimental_rules/modsecurity_crs_40_appsensor_detection_point_2.1_request_exception.conf \
			experimental_rules/modsecurity_crs_41_advanced_filters.conf \
			experimental_rules/modsecurity_crs_55_response_profiling.conf \
			experimental_rules/modsecurity_crs_56_pvi_checks.conf \
			|| die
	else
		# fix up the path to the scripts; there seems to be no
		# consistency at all on how the rules are loaded.
		sed -i \
			-e "s:/etc/apache2/modsecurity-crs/lua/:${LUADIR}/:" \
			-e "s:profile_page_scripts.lua:${LUADIR}/\0:" \
			-e "s:/usr/local/apache/conf/crs/lua/:${LUADIR}/:" \
			-e "s:/usr/local/apache/conf/modsec_current/base_rules/:${LUADIR}/:" \
			-e "s:/etc/apache2/modsecurity-crs/lua/:${LUADIR}/:" \
			-e "s:\.\./lua/:${LUADIR}/:" \
			*_rules/*.conf || die

		# fix up the shebang on the scripts
		sed -i -e "s:/opt/local/bin/lua:/usr/bin/lua:" \
			lua/*.lua || die
	fi

	sed -i \
		-e '/SecGeoLookupDb/s:^:#:' \
		-e '/SecGeoLookupDb/a# Gentoo already defines it in 79_modsecurity.conf' \
		experimental_rules/modsecurity_crs_61_ip_forensics.conf || die

	if ! use geoip; then
		if use lua; then
			# only comment this out as the file is going to be used for other things
			sed -i -e "/id:'960007'/,+1 s:^:#:" \
				experimental_rules/modsecurity_crs_61_ip_forensics.conf || die
		else
			rm experimental_rules/modsecurity_crs_61_ip_forensics.conf || die
		fi
	fi
}

src_install() {
	insinto "${RULESDIR}"
	doins -r base_rules optional_rules experimental_rules

	insinto "${LUADIR}"
	doins lua/*.lua

	dodoc CHANGELOG README

	(
		cat - <<EOF
<IfDefine SECURITY>
EOF

		cat modsecurity_crs_10_setup.conf.example

		cat - <<EOF

Include /etc/modsecurity/base_rules/*.conf

# Optionally use the other rules as well
# Include /etc/modsecurity/optional_rules/*.conf
# Include /etc/modsecurity/experimental_rules/*.conf
</IfDefine>

# -*- apache -*-
# vim: ts=4 filetype=apache

EOF
	) > "${T}"/"80_${PN}.conf"

	insinto /etc/apache2/modules.d/
	doins "${T}"/"80_${PN}.conf"
}

pkg_postinst() {
	elog
	elog "If you want to enable further rules, check the following directories:"
	elog "	${RULESDIR}/optional_rules"
	elog "	${RULESDIR}/experimental_rules"
	elog ""
	elog "Starting from version 2.0.9, the default for the Core Rule Set is again to block"
	elog "when rules hit. If you wish to go back to the 2.0.8 method of anomaly scoring, you"
	elog "should change 80_${PN}.conf so that you have these settings enabled:"
	elog ""
	elog "    #SecDefaultAction \"phase:2,deny,log\""
	elog "    SecAction \"phase:1,t:none,nolog,pass,setvar:tx.anomaly_score_blocking=on\""
	elog ""
	elog "Starting from version 2.1.2 rules are installed, for consistency, under"
	elog "/etc/modsecurity, and can be configured with the following file:"
	elog "  /etc/apache2/modules.d/80_${PN}.conf"
	elog ""
}
