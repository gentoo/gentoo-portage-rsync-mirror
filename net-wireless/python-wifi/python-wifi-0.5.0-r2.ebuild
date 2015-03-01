# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/python-wifi/python-wifi-0.5.0-r1.ebuild,v 1.13 2012/12/16 15:25:55 armin76 Exp $

EAPI=5

PYTHON_COMPAT=( python2_7 )
DISTUTILS_SINGLE_IMPL=1

inherit distutils-r1

DESCRIPTION="Provides r/w access to a wireless network card's capabilities using the Linux Wireless Extensions"
HOMEPAGE="http://pypi.python.org/pypi/python-wifi"
SRC_URI="mirror://sourceforge/${PN}.berlios/${P}.tar.bz2"

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
	distutils-r1_src_install
	if use examples; then
		insinto /usr/share/${P}/
		doins -r examples
	fi
	rm -rvf "${ED}"/usr/{docs,examples,INSTALL,README} || die
	mv -v "${ED}"/usr{,/share}/man || die
}
