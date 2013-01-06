# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/b2evolution/b2evolution-4.1.6.ebuild,v 1.5 2013/01/01 18:33:12 armin76 Exp $

EAPI=4

inherit webapp eutils

MY_EXT="stable-2012-11-23"
MY_PV=${PV/_/-}

DESCRIPTION="Multilingual multiuser multi-blog engine"
HOMEPAGE="http://www.b2evolution.net"
SRC_URI="mirror://sourceforge/evocms/${PN}-${MY_PV}-${MY_EXT}.zip"

LICENSE="GPL-2"
KEYWORDS="amd64 ppc x86"
IUSE=""

RDEPEND="virtual/httpd-php
	dev-lang/php[ctype,curl,mysql,tokenizer,xml]"
DEPEND="${RDEPEND}
	app-arch/unzip"

need_httpd_cgi

S="${WORKDIR}/${PN}"

src_install() {
	webapp_src_preinst

	insinto "${MY_HTDOCSDIR}"
	doins -r blogs/*

	rm doc/*.*-*.html doc/*.src.html
	dohtml doc/*.html

	webapp_serverowned "${MY_HTDOCSDIR}"/conf/_basic_config.template.php
	webapp_serverowned "${MY_HTDOCSDIR}"/{cache,media}/
	webapp_configfile
	"${MY_HTDOCSDIR}"/conf/_{basic_config.template,advanced,locales,formatting,admin,stats,application,config,icons,upgrade}.php

	webapp_postinst_txt en "${FILESDIR}"/postinstall-en.txt
	webapp_postupgrade_txt en "${FILESDIR}"/postupgrade-en.txt

	webapp_src_install
}
