# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/python-wifi/python-wifi-0.5.0-r2.ebuild,v 1.1 2015/03/28 03:55:49 idella4 Exp $

EAPI=5

PYTHON_COMPAT=( python2_7 )
DISTUTILS_SINGLE_IMPL=1

inherit distutils-r1

DESCRIPTION="Provides r/w access to a wireless network card's capabilities using Linux Wireless Extensions"
HOMEPAGE="http://pypi.python.org/pypi/python-wifi https://developer.berlios.de/projects/pythonwifi"
SRC_URI="mirror://berlios/${PN/-}/${P}.tar.bz2"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"
LICENSE="LGPL-2.1 examples? ( GPL-2 )"
IUSE="examples"

RDEPEND=""
DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"

DOCS="docs/AUTHORS docs/BUGS docs/DEVEL.txt docs/TODO"

pkg_setup() {
	python-single-r1_pkg_setup
}

src_install() {
	# The section data_files=[ in setup.py competes with the elcass awfully.
	# Without patching a setup.py from 2102 we have to manually adjust post install

	use examples & local EXAMPLES=( examples/. )

	distutils-r1_src_install

	# NEVER before has it been necessary to code for both use and non use of this use flag
	if ! use examples; then
		rm -rf "${D}"/usr/share/doc/${PF}/examples/ || die
	fi
	rm -rvf "${D}"usr/{docs,examples,INSTALL,README} || die
	mv -v "${D}"usr{,/share}/man || die
}
