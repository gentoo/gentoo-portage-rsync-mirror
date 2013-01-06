# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/mantisbt/mantisbt-1.2.11.ebuild,v 1.3 2012/10/08 08:10:48 nativemad Exp $

EAPI="2"

inherit eutils webapp depend.php

DESCRIPTION="PHP/MySQL/Web based bugtracking system"
HOMEPAGE="http://www.mantisbt.org/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="
	virtual/httpd-php
	virtual/httpd-cgi
	|| ( <dev-lang/php-5.3[pcre] >=dev-lang/php-5.3 )
	>=dev-php/ezc-Base-1.8
	>=dev-php/ezc-Graph-1.5
	>=dev-php/adodb-5.10"

src_prepare() {
	# Drop external libraries
	rm -r "${S}/library/adodb/"
	rm -r "${S}/library/ezc/"{Base,Graph}
	sed -e 's:ezc/Base/src/base.php:ezc/Base/base.php:' \
		-i "${S}"/plugins/MantisGraph/{core/graph_api.php,pages/summary_graph_cumulative_bydate2.php} \
			|| die
	# Fix incorrect filename
	sed -e 's:config_default_inc.php:config_defaults_inc.php:' \
		-i "${S}/lang/strings_russian.txt" || die
}

src_install() {
	webapp_src_preinst
	rm doc/{LICENSE,INSTALL}
	dodoc doc/{CREDITS,CUSTOMIZATION,RELEASE} doc/en/*

	rm -rf doc packages
	mv config_inc.php.sample config_inc.php
	cp -R . "${D}/${MY_HTDOCSDIR}"

	webapp_configfile "${MY_HTDOCSDIR}/config_inc.php"
	webapp_postinst_txt en "${FILESDIR}/postinstall-en-1.0.0.txt"
	webapp_src_install
}
