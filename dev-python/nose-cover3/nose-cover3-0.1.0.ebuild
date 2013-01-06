# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/nose-cover3/nose-cover3-0.1.0.ebuild,v 1.2 2012/06/12 11:37:53 iksaif Exp $

EAPI="4"

PYTHON_DEPEND="2 3"
RESTRICT_PYTHON_ABIS="2.4"
SUPPORT_PYTHON_ABIS="1"
DISTUTILS_SRC_TEST="nosetests"

inherit distutils

DESCRIPTION="Coverage 3.x support for Nose"
HOMEPAGE="https://github.com/ask/nosecover3 http://pypi.python.org/pypi/nose-cover3"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="dev-python/nose"
DEPEND="${RDEPEND}
	dev-python/setuptools"

PYTHON_MODNAME="nosecover3"
