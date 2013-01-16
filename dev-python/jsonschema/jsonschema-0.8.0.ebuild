# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/jsonschema/jsonschema-0.8.0.ebuild,v 1.1 2013/01/16 03:03:55 chutzpah Exp $

EAPI="5"

PYTHON_COMPAT=(python2_7 python3_2 python3_3)
inherit distutils-r1

DESCRIPTION="An implementation of JSON-Schema validation for Python"
HOMEPAGE="http://pypi.python.org/pypi/jsonschema"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND=""
