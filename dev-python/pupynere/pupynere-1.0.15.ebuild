# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pupynere/pupynere-1.0.15.ebuild,v 1.2 2012/08/02 18:14:13 bicatali Exp $

EAPI=4
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils

DESCRIPTION="Pupynere is a PUre PYthon NEtcdf REader."
HOMEPAGE="http://pypi.python.org/pypi/pupynere/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE=""

RDEPEND="dev-python/numpy"
DEPEND="${RDEPEND}
	dev-python/setuptools"

PYTHON_MODNAME="pupynere.py"
