# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/joomla/joomla-1.5.25.ebuild,v 1.1 2011/12/13 19:44:49 fauli Exp $

EAPI=2

inherit webapp depend.php

DESCRIPTION="Joomla is a powerful Open Source Content Management System."
HOMEPAGE="http://www.joomla.org/"
SRC_URI="http://joomlacode.org/gf/download/frsrelease/16026/69665/Joomla_${PV}-Stable-Full_Package.zip"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

need_httpd_cgi
need_php_httpd

S="${WORKDIR}"

DEPEND="${DEPEND}
	app-arch/unzip"
RDEPEND="dev-lang/php[mysql,zlib,xml]"

src_install () {
	webapp_src_preinst

	dodoc CHANGELOG.php INSTALL.php

	touch configuration.php
	insinto "${MY_HTDOCSDIR}"
	doins -r .

	local files="administrator/backups administrator/cache
	administrator/components administrator/language administrator/language/en-GB
	administrator/modules administrator/templates cache components images
	images/banners images/stories language language/en-GB language/pdf_fonts
	media modules plugins plugins/content plugins/editors plugins/editors-xtd
	plugins/search plugins/system plugins/user plugins/xmlrpc tmp templates"

	for file in ${files}; do
		webapp_serverowned "${MY_HTDOCSDIR}"/${file}
	done

	webapp_configfile "${MY_HTDOCSDIR}"/configuration.php
	webapp_serverowned "${MY_HTDOCSDIR}"/configuration.php

	webapp_postinst_txt en "${FILESDIR}"/postinstall-en.txt
	webapp_src_install
}
