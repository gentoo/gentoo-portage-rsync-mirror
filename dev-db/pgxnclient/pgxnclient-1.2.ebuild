# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/pgxnclient/pgxnclient-1.2.ebuild,v 1.1 2013/01/17 07:36:31 patrick Exp $

EAPI="5"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="*-jython 2.7-pypy-* *-jython"

inherit distutils eutils

DESCRIPTION="PostgreSQL Extension Network Client"
HOMEPAGE="http://pgxnclient.projects.postgresql.org/ http://pypi.python.org/pypi/${PN}"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"

LICENSE="BSD"
SLOT="0"
IUSE=""

RDEPEND=">=dev-db/postgresql-server-9.1"
DEPEND="${RDEPEND}"
