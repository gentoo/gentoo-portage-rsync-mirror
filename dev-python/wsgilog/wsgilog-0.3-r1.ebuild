# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/wsgilog/wsgilog-0.3-r1.ebuild,v 1.3 2014/03/31 20:50:58 mgorny Exp $

EAPI="5"
PYTHON_COMPAT=( python2_7 pypy pypy2_0 )

inherit distutils-r1

DESCRIPTION="Class for logging in WSGI-applications"
HOMEPAGE="http://pypi.python.org/pypi/wsgilog/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

DOCS="PKG-INFO"
