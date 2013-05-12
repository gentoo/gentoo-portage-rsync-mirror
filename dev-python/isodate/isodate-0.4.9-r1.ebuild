# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/isodate/isodate-0.4.9-r1.ebuild,v 1.1 2013/05/12 16:43:50 jlec Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7,3_1,3_2,3_3} jython2_5 )

inherit distutils-r1

DESCRIPTION="ISO 8601 date/time/duration parser and formater"
HOMEPAGE="http://pypi.python.org/pypi/isodate"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~amd64-linux ~x86-linux"
IUSE=""

DEPEND="dev-python/setuptools"

DOCS=( CHANGES.txt README.txt TODO.txt )
