# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/orm/orm-1.0.1.ebuild,v 1.4 2010/07/23 23:36:00 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils

DESCRIPTION="The Object Relational Membrane is an attempt to write an Object Relational Layer that is as thin as possible."
HOMEPAGE="http://www.tux4web.de/computer/software/orm/"
SRC_URI="http://www.tux4web.de/computer/software/orm/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="firebird mysql +postgres"

DEPEND="dev-python/egenix-mx-base
	firebird? ( >=dev-python/kinterbasdb-3.1_pre7 )
	mysql? ( >=dev-python/mysql-python-0.9.2 )
	postgres? ( dev-python/psycopg:0 )"
RDEPEND="${DEPEND}"

pkg_setup() {
	python_pkg_setup

	( use firebird || use mysql || use postgres ) || \
	die "Using orm without any db makes no sense. Please enable at least one use flag."
}
