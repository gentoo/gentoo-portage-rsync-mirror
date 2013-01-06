# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/trac-git/trac-git-20111119.ebuild,v 1.2 2012/02/22 02:24:56 idl0r Exp $

EAPI="4"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils

DESCRIPTION="A git plugin for Trac"
HOMEPAGE="http://trac-hacks.org/wiki/GitPlugin"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/setuptools"
RDEPEND=">=www-apps/trac-0.12
	dev-vcs/git"

src_install() {
	distutils_src_install

	install_init() {
		touch "${D}/$(python_get_sitedir)/tracext/__init__.py"
	}
	python_execute_function -q install_init

	rm -f "${D}"/usr/{README,COPYING}
}
