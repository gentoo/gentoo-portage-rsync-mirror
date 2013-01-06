# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/ganglia-web/ganglia-web-3.5.2.ebuild,v 1.4 2012/09/22 13:50:30 blueness Exp $

EAPI=4
WEBAPP_MANUAL_SLOT="yes"
inherit webapp eutils

DESCRIPTION="Web frontend for sys-cluster/ganglia"
HOMEPAGE="http://ganglia.sourceforge.net"
SRC_URI="mirror://sourceforge/ganglia/${PN}/${PV}/${P}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="vhosts"

DEPEND="net-misc/rsync"
RDEPEND="
	${DEPEND}
	${WEBAPP_DEPEND}
	>=sys-cluster/ganglia-3.3.7[-minimal]
	dev-lang/php[gd,xml,ctype,cgi]
	media-fonts/dejavu"

src_configure() {
	return 0
}

src_compile() {
	return 0
}

src_install() {
	webapp_src_preinst
	cd "${S}"
	emake \
		GDESTDIR="${MY_HTDOCSDIR}" \
		DESTDIR="${D}" \
		APACHE_USER=nobody \
		install || die
	webapp_configfile "${MY_HTDOCSDIR}"/conf_default.php
	webapp_src_install

	keepdir /var/lib/ganglia/rrds
	fowners nobody:nobody /var/lib/ganglia/rrds
	fowners -R nobody:nobody /var/lib/ganglia/dwoo
	fperms -R 777 /var/lib/ganglia/dwoo

	dodoc AUTHORS README TODO || die
}
