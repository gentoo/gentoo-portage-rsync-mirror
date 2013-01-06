# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/turbojson/turbojson-1.1.4.ebuild,v 1.5 2012/02/20 14:20:08 patrick Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"
DISTUTILS_SRC_TEST="setup.py"

inherit distutils

MY_PN="TurboJson"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="TurboGears JSON file format support plugin"
HOMEPAGE="http://pypi.python.org/pypi/TurboJson"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE="test"

RDEPEND=">=dev-python/decoratortools-1.4
	dev-python/ruledispatch
	>=dev-python/simplejson-1.3"
DEPEND="${RDEPEND}
	dev-python/setuptools
	test? ( dev-python/nose )"

S="${WORKDIR}/${MY_P}"
