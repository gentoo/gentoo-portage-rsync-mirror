# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/openvas/openvas-8_beta4.ebuild,v 1.1 2014/12/01 17:01:06 jlec Exp $

EAPI=5

inherit readme.gentoo

DESCRIPTION="A remote security scanner"
HOMEPAGE="http://www.openvas.org/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS=""
IUSE="+pdf"

DEPEND="
	>=net-analyzer/openvas-libraries-8_beta4
	>=net-analyzer/openvas-scanner-5_beta4
	>=net-analyzer/openvas-manager-6_beta4
	>=net-analyzer/openvas-cli-1.4_beta4
	net-analyzer/openvas-tools
	>=net-analyzer/greenbone-security-assistant-6_beta4
	pdf? (
		app-text/htmldoc
		dev-texlive/texlive-latexextra
		virtual/latex-base
	)"
# greenbone-security-desktop is broken and unsupported upstream
RDEPEND="${DEPEND}"

S="${WORKDIR}"

pkg_postinst() {
	elog "Additional support for extra checks can be get from"
	optfeature "Nikto — a web server scanning and testing tool" net-analyzer/nikto
	optfeature "NMAP — a portscanner" net-analyzer/nmap
	optfeature "ike-scan - an IPsec VPN scanning, fingerprinting and testing tool" net-analyzer/ike-scan
	optfeature "amap — an application protocol detection tool" net-analyzer/amap
	optfeature "ldapsearch from OpenLDAP utilities — retrieves information from LDAP dictionaries" net-nds/openldap
	optfeature "ovaldi (OVAL) — an OVAL Interpreter" app-forensics/ovaldi
	optfeature "portbunny — a Linux-kernel-based portscanner" net-analyzer/portbunny
	optfeature "w3af — a web application attack and audit framework" net-analyzer/w3af
}
