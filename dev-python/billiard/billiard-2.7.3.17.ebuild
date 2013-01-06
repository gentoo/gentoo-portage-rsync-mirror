# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/billiard/billiard-2.7.3.17.ebuild,v 1.2 2012/11/09 13:26:26 idella4 Exp $

EAPI="4"

PYTHON_DEPEND="*:2.5"
RESTRICT_PYTHON_ABIS="2.4"
SUPPORT_PYTHON_ABIS="1"
DISTUTILS_SRC_TEST="nosetests"
inherit distutils

DESCRIPTION="Python multiprocessing fork"
HOMEPAGE="http://pypi.python.org/pypi/billiard https://github.com/celery/billiard"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="test"

RDEPEND=""
DEPEND="${RDEPEND}
	dev-python/setuptools"
