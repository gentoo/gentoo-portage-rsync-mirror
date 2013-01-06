# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-daap/python-daap-0.7.1.ebuild,v 1.3 2012/02/23 02:55:19 patrick Exp $

EAPI="3"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* *-jython"

inherit distutils

MY_P="PythonDaap-${PV}"

DESCRIPTION="PyDaap is a DAAP client implemented in Python, based on PyTunes"
HOMEPAGE="http://jerakeen.org/code/pythondaap"
SRC_URI="http://jerakeen.org/files/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="examples"

DEPEND=""
RDEPEND=""

S="${WORKDIR}/${MY_P}"

PYTHON_MODNAME="daap.py"

src_install() {
	distutils_src_install

	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r examples
	fi
}
