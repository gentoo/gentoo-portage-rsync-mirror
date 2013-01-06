# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/turbokid/turbokid-1.0.5.ebuild,v 1.2 2010/12/26 15:48:05 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"
DISTUTILS_SRC_TEST="setup.py"

inherit distutils

MY_PN="TurboKid"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Python template plugin that supports Kid templates"
HOMEPAGE="http://pypi.python.org/pypi/TurboKid"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

S="${WORKDIR}/${MY_P}"

RDEPEND=">=dev-python/kid-0.9.6"
DEPEND="${RDEPEND}
	dev-python/setuptools
	test? ( dev-python/nose )"
