# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/drraw/drraw-2.0.1.ebuild,v 1.5 2008/02/22 17:06:43 hollow Exp $

inherit webapp

DESCRIPTION="drraw is a simple web based presentation front-end for RRDtool"
HOMEPAGE="http://web.taranis.org/drraw"
SRC_URI="http://web.taranis.org/${PN}/dist/${P}.tgz"

LICENSE="GPL-2"
KEYWORDS="~x86 ppc"
IUSE=""

RDEPEND=">=dev-lang/perl-5.6
	virtual/perl-CGI
	>=net-analyzer/rrdtool-1.0.47"

need_httpd_cgi

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i -e "s|/usr/local/bin/perl|/usr/bin/perl|" drraw.cgi
	sed -i \
		-e "s|/somewhere/drraw/saved|/tmp|" \
		-e "s|/somewhere/drraw/tmp|/tmp|" \
		drraw.conf
}

src_install() {
	webapp_src_preinst

	dodoc CHANGES INSTALL README.EVENTS WISHLIST
	rm CHANGES INSTALL README.EVENTS WISHLIST

	insinto "${MY_CGIBINDIR}"
	doins drraw.conf

	exeinto "${MY_CGIBINDIR}"
	doexe drraw.cgi

	insinto "${MY_ICONSDIR}"
	doins icons/*.gif

	webapp_configfile "${MY_CGIBINDIR}"/drraw.conf

	webapp_postinst_txt en "${FILESDIR}"/postinstall-en.txt
	webapp_src_install
}
