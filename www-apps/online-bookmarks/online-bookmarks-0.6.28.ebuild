# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/online-bookmarks/online-bookmarks-0.6.28.ebuild,v 1.2 2008/09/19 18:51:15 dertobi123 Exp $

inherit webapp depend.php

S=${WORKDIR}/${PN}

DESCRIPTION="A Bookmark management system to store your Bookmarks, Favorites and Links."
HOMEPAGE="http://www.frech.ch/online-bookmarks/index.php"
SRC_URI="http://www.frech.ch/online-bookmarks/download/old_versions/0.6.x/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~amd64 ppc ~x86"

IUSE=""

RDEPEND=">=virtual/httpd-php-4.3.0
	dev-php/PEAR-Auth
	dev-php/PEAR-DB
"

src_unpack() {
	unpack ${A}
	require_php_with_use mysql
}

src_compile() {
	einfo "Nothing to compile"
}

src_install() {
	webapp_src_preinst

	dodoc CHANGES README

	cp -R * "${D}/${MY_HTDOCSDIR}"

	webapp_configfile "${MY_HTDOCSDIR}/login.php"

	webapp_serverowned "${MY_HTDOCSDIR}/favicons"

	webapp_postinst_txt en "${FILESDIR}/postinstall-en.txt"
	webapp_src_install
}
