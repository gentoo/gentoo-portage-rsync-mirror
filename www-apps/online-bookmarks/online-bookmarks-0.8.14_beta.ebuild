# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/online-bookmarks/online-bookmarks-0.8.14_beta.ebuild,v 1.1 2012/06/24 10:32:20 mabi Exp $

EAPI=4

inherit webapp

S="${WORKDIR}/${PN}"

DESCRIPTION="A Bookmark management system to store your Bookmarks, Favorites and Links."
HOMEPAGE="http://www.frech.ch/online-bookmarks/index.php"
SRC_URI="http://www.frech.ch/online-bookmarks/download/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~x86"

IUSE=""
RDEPEND="virtual/httpd-php
	dev-lang/php[mysql]
	dev-php/PEAR-Auth
	dev-php/PEAR-DB"

src_install() {
	webapp_src_preinst

	dodoc CHANGES README

	cp -R * "${D}/${MY_HTDOCSDIR}"

	webapp_serverowned "${MY_HTDOCSDIR}/favicons"

	webapp_postinst_txt en "${FILESDIR}/postinstall-en.txt"
	webapp_src_install
}
