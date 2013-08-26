# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/euscan/euscan-0.1.1.ebuild,v 1.4 2013/08/26 16:51:26 bicatali Exp $

EAPI="3"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.[45] 3.* 2.7-pypy-*"
PYTHON_USE_WITH="xml"
PYTHON_NONVERSIONED_EXECUTABLES=(".*")

inherit distutils python

DESCRIPTION="Ebuild upstream scan utility"
HOMEPAGE="http://euscan.iksaif.net"
SRC_URI="http://dev.gentoo.org/~hwoarang/distfiles/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
IUSE=""

KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"

DEPEND="sys-apps/portage"
RDEPEND="${DEPEND}
	>=app-portage/gentoolkit-0.2.8
	dev-python/setuptools
	dev-python/beautifulsoup:python-2
	virtual/python-argparse"

distutils_src_compile_pre_hook() {
	echo VERSION="${PV}" "$(PYTHON)" setup.py set_version
	VERSION="${PV}" "$(PYTHON)" setup.py set_version
}

src_compile() {
	distutils_src_compile
}
