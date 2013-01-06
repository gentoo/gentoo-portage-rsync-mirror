# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-client/roundcube/roundcube-0.8.1.ebuild,v 1.5 2012/11/29 16:20:08 ago Exp $

EAPI="4"

inherit webapp

MY_PN="${PN}mail"
MY_P="${MY_PN}-${PV/_/-}"
DESCRIPTION="A browser-based multilingual IMAP client with an application-like user interface"
HOMEPAGE="http://roundcube.net"
SRC_URI="mirror://sourceforge/${MY_PN}/${MY_P}.tar.gz"

# roundcube is GPL-licensed, the rest of the licenses here are
# for bundled PEAR components, googiespell and utf8.class.php
LICENSE="GPL-3 BSD PHP-2.02 PHP-3 MIT public-domain"
KEYWORDS="amd64 arm ~hppa ppc ~ppc64 ~sparc x86"
IUSE="ldap +mysql postgres ssl spell"

RDEPEND="virtual/httpd-php
	>=dev-lang/php-5.3[crypt,gd,iconv,json,ldap?,postgres?,session,sockets,ssl?,xml,unicode]
	mysql? (
		|| ( dev-lang/php[mysql] dev-lang/php[mysqli] )
		|| ( dev-php/PEAR-MDB2_Driver_mysql dev-php/PEAR-MDB2_Driver_mysqli )
	)
	postgres? ( dev-php/PEAR-MDB2_Driver_pgsql )
	spell? ( dev-lang/php[curl,spell] )
	>=dev-php/PEAR-MDB2-2.5.0_beta3
	>=dev-php/PEAR-Mail_Mime-1.8.1
	>=dev-php/PEAR-Net_SMTP-1.4.2
	>=dev-php/PEAR-Net_IDNA2-0.1.1
	>=dev-php/PEAR-Auth_SASL-1.0.3"

need_httpd_cgi

S=${WORKDIR}/${MY_P}

src_prepare() {
	cp config/db.inc.php{.dist,} || die
	cp config/main.inc.php{.dist,} || die

	# Remove bundled PEAR packages
	rm -r program/lib/{Auth,Mail,MDB2*,Net,PEAR*} || die
}

src_install() {
	webapp_src_preinst
	dodoc CHANGELOG INSTALL README.md UPGRADING

	insinto "${MY_HTDOCSDIR}"
	doins -r [[:lower:]]* SQL
	doins .htaccess

	webapp_serverowned "${MY_HTDOCSDIR}"/logs
	webapp_serverowned "${MY_HTDOCSDIR}"/temp

	webapp_configfile "${MY_HTDOCSDIR}"/config/{db,main}.inc.php
	webapp_postinst_txt en "${FILESDIR}"/postinstall-en-0.6.txt
	webapp_postupgrade_txt en "${FILESDIR}"/postupgrade-en-0.6.txt
	webapp_postupgrade_txt en UPGRADING
	webapp_src_install
}
