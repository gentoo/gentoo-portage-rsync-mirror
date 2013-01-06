# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/turbocheetah/turbocheetah-1.0.ebuild,v 1.3 2010/12/26 15:47:34 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"
DISTUTILS_SRC_TEST="nosetests"

inherit distutils

MY_PN="TurboCheetah"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="TurboGears plugin to support use of Cheetah templates."
HOMEPAGE="http://docs.turbogears.org/TurboCheetah http://pypi.python.org/pypi/TurboCheetah"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-python/cheetah-1.0"
DEPEND="${RDEPEND}
	dev-python/setuptools"

S="${WORKDIR}/${MY_P}"
