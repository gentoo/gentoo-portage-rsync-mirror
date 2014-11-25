# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyalsaaudio/pyalsaaudio-0.7-r2.ebuild,v 1.3 2014/11/25 10:03:58 pacho Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7,3_2,3_3,3_4} )

inherit distutils-r1

DESCRIPTION="A Python wrapper for the ALSA API"
HOMEPAGE="http://www.sourceforge.net/projects/pyalsaaudio http://pypi.python.org/pypi/pyalsaaudio"
SRC_URI="mirror://sourceforge/pyalsaaudio/${P}.tar.gz mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="PSF-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ppc ~sparc ~x86"
IUSE="doc"

RDEPEND="media-libs/alsa-lib"
DEPEND="${RDEPEND}
	doc? ( >=dev-python/sphinx-0.6[${PYTHON_USEDEP}] )"

RESTRICT="test" # Direct access to ALSA, shouln't be used

DOCS=( CHANGES README )

python_compile_all() {
	use doc && emake -C doc html
}

python_install_all() {
	use doc && local HTML_DOCS=( doc/html/. )
	local EXAMPLES=( *test.py )

	distutils-r1_python_install_all
}
