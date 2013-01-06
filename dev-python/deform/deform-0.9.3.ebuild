# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/deform/deform-0.9.3.ebuild,v 1.1 2012/02/08 02:56:49 patrick Exp $

EAPI="3"

SUPPORT_PYTHON_ABIS=1
PYTHON_DEPEND="2:2.6"
RESTRICT_PYTHON_ABIS="2.5 3.*"
DISTUTILS_SRC_TEST="setup.py"

inherit distutils

DESCRIPTION="Another form generation library"
HOMEPAGE="http://pylonsproject.org/ http://pypi.python.org/pypi/deform"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="repoze"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="dev-python/translationstring
	>=dev-python/colander-0.8
	>=dev-python/peppercorn-0.3
	>=dev-python/chameleon-1.2.3"

DEPEND="${RDEPEND}
	test? ( dev-python/beautifulsoup )"

# docs are broken
