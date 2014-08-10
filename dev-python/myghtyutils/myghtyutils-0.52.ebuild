# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/myghtyutils/myghtyutils-0.52.ebuild,v 1.5 2014/08/10 21:14:16 slyfox Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils

MY_PN="MyghtyUtils"
MY_P=${MY_PN}-${PV}

DESCRIPTION="Set of utility classes used by Myghty templating"
HOMEPAGE="http://www.myghty.org http://pypi.python.org/pypi/MyghtyUtils"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.zip"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-python/myghty"
DEPEND="${RDEPEND}
	app-arch/unzip
	dev-python/setuptools"

S="${WORKDIR}/${MY_P}"
