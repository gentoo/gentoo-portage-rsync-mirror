# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/xvfbwrapper/xvfbwrapper-0.2.2.ebuild,v 1.1 2013/05/31 04:17:24 floppym Exp $

EAPI=5
PYTHON_COMPAT=( python{2_7,3_2,3_3} )

inherit distutils-r1

DESCRIPTION="Python wrapper for running a display inside X virtual framebuffer"
HOMEPAGE="https://github.com/cgoldberg/xvfbwrapper
	http://pypi.python.org/pypi/xvfbwrapper"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="x11-base/xorg-server[xvfb]"
DEPEND="${RDEPEND}
	test? ( dev-python/pep8[${PYTHON_USEDEP}] )
"

python_test() {
	unset DISPLAY
	"${PYTHON}" -m unittest discover || die "Tests failed with ${EPYTHON}"
}
