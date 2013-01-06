# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/mysqltuner/mysqltuner-1.1.1.ebuild,v 1.3 2010/03/28 14:32:36 maekke Exp $

EAPI="2"

DESCRIPTION="MySQLTuner is a high-performance MySQL tuning script"
HOMEPAGE="http://www.mysqltuner.com"
SRC_URI="http://github.com/rackerhacker/MySQLTuner-perl/tarball/v${PV} -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND=""
RDEPEND=">=dev-lang/perl-5.6
	virtual/perl-Getopt-Long
	>=virtual/mysql-3.23"

S="${WORKDIR}"/rackerhacker-MySQLTuner-perl-b2dfc87

src_install() {
	mv "${PN}".pl "${PN}"
	dobin "${PN}"
	dodoc README
}
