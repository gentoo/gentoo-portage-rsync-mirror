# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/orm/orm-1.0.1-r1.ebuild,v 1.1 2014/12/23 03:06:57 idella4 Exp $

EAPI="5"
PYTHON_COMPAT=( python2_7 )

inherit distutils-r1

DESCRIPTION="The Object Relational Membrane is an attempt to write a minimal Object Relational Layer"
HOMEPAGE="http://www.tux4web.de/computer/software/orm/"
SRC_URI="http://www.tux4web.de/computer/software/orm/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="mysql postgres"

DEPEND="dev-python/egenix-mx-base[${PYTHON_USEDEP}]
	mysql? ( >=dev-python/mysql-python-0.9.2[${PYTHON_USEDEP}] )
	postgres? ( dev-python/psycopg:0[${PYTHON_USEDEP}] )"
RDEPEND="${DEPEND}"

REQUIRED_USE="|| ( mysql postgres )"
