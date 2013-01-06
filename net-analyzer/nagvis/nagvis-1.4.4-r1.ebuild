# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/nagvis/nagvis-1.4.4-r1.ebuild,v 1.1 2012/06/22 20:56:51 mabi Exp $

EAPI=4

inherit eutils

DESCRIPTION="NagVis is a visualization addon for the well known network managment system Nagios."
HOMEPAGE="http://www.nagvis.org/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="automap"

DEPEND=""
RDEPEND=">=net-analyzer/ndoutils-1.4_beta4
		automap? ( >=media-gfx/graphviz-2.14 )
		virtual/httpd-php
		dev-lang/php[gd,mysql,unicode]"

src_install() {
	for docfile in README INSTALL
	do
		dodoc ${docfile}
		rm ${docfile}
	done

	grep -Rl "/usr/local" "${S}"/* | xargs sed -i s:/usr/local:/usr:g

	dodir /usr/share/nagvis
	mv "${S}"/{config.php,index.php,nagvis,wui} "${D}"/usr/share/nagvis/

	dodir /var/nagvis
	dosym /var/nagvis /usr/share/nagvis/var
	fowners apache:root /var/nagvis

	dodir /etc/nagvis
	mv "${S}"/etc/* "${D}"/etc/nagvis/
	dosym /etc/nagvis /usr/share/nagvis/etc

	fperms 664 /etc/nagvis/nagvis.ini.php-sample
	fperms 775 /etc/nagvis/maps
	fperms -R 664 /etc/nagvis/maps/
	fowners -R apache:root /etc/nagvis/maps/
}

pkg_postinst() {
	elog "Before running NagVis for the first time, you will need to set up"
	elog "/etc/nagvis/nagvis.ini.php"
	elog "A sample is in"
	elog "/etc/nagvis/nagvis.ini.php-sample"
}
