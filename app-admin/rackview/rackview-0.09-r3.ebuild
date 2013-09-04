# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/rackview/rackview-0.09-r3.ebuild,v 1.1 2013/09/04 12:00:20 idella4 Exp $

EAPI=5

inherit perl-module webapp

DESCRIPTION="Generate HTML page displaying computer rack layout"
HOMEPAGE="http://rackview.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE=""
SLOT="0"
WEBAPP_MANUAL_SLOT="yes"

DEPEND=">=dev-perl/Config-Simple-4.1
	>=dev-perl/GD-1.41
	>=dev-perl/Eidetic-2
	>=virtual/perl-File-Spec-0.83
	>=virtual/perl-File-Temp-0.12
	>=www-apache/mod_auth_mysql-3.0.0-r2
	!<=app-admin/rackview-0.09-r1"

RDEPEND=""

src_install() {
	webapp_src_preinst
	myinst="${myinst} DESTDIR=${D} INSTBINDIR=${D}/usr/bin"
	perl-module_src_install

	insinto ${MY_HTDOCSDIR}
	doins example/index.html example/top_view.png example/top_view.svg

	insinto ${MY_CGIBINDIR}
	doins cgi-bin/*

	insinto /etc/eidetic
	doins example/example.dat

	insinto /etc/rackview/
	doins etc/*

	dodoc doc/*

	webapp_src_install
}
