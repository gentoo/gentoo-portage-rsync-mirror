# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/libchart/libchart-1.2.1.ebuild,v 1.1 2011/04/09 19:15:10 olemarkus Exp $

EAPI="2"

inherit php-lib-r1 depend.php

DESCRIPTION="Libchart is a chart creation PHP library that is easy to use."
HOMEPAGE="http://naku.dohcrew.com/libchart"
SRC_URI="http://libchart.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-3 BitstreamVera"
KEYWORDS="~x86 ~amd64"
SLOT=0
IUSE="examples"

need_php5

DEPEND=""
RDEPEND="dev-lang/php[truetype]
	|| ( dev-lang/php[gd] dev-lang/php[gd-external] )"

src_install() {
	php-lib-r1_src_install ${PN} `cd ${PN}; find . -type f -print`
	for i in ${PN}/{ChangeLog,README} ; do
		dodoc-php ${i}
		rm -f ${i}
	done
	if use examples ; then
		insinto /usr/share/doc/${CATEGORY}/${PF}
		doins -r demo/
	fi
}
