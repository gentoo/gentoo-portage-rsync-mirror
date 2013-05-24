# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/barman/barman-1.2.0-r1.ebuild,v 1.1 2013/05/24 08:41:44 patrick Exp $
EAPI=4
SUPPORT_PYTHON_ABIS="1"
PYTHON_DEPEND="2:2.6:2.7"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils

DESCRIPTION="Administration tool for disaster recovery of PostgreSQL servers"

HOMEPAGE="http://www.pgbarman.org"
SRC_URI="http://downloads.sourceforge.net/project/pgbarman/${PV}/${P}.tar.gz"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE=""

RDEPEND="dev-python/argh
	>=dev-python/psycopg-2
	dev-python/python-dateutil
	net-misc/rsync
	dev-db/postgresql-server"
DEPEND=""

pkg_setup() {
        python_set_active_version 2
        python_pkg_setup
}
