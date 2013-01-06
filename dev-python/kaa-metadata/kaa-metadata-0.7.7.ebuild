# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/kaa-metadata/kaa-metadata-0.7.7.ebuild,v 1.6 2012/02/23 07:54:50 patrick Exp $

EAPI="3"
PYTHON_DEPEND="2:2.5"
PYTHON_USE_WITH="threads"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.4 3.* 2.7-pypy-* *-jython"

inherit distutils

DESCRIPTION="Powerful media metadata parser for media files in Python, successor of MMPython"
HOMEPAGE="http://freevo.sourceforge.net/kaa/"
SRC_URI="mirror://sourceforge/freevo/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="css dvd"

DEPEND=">=dev-python/kaa-base-0.3.0
	css? ( media-libs/libdvdcss )
	dvd? ( media-libs/libdvdread )"
RDEPEND="${DEPEND}"

PYTHON_MODNAME="kaa"

src_prepare() {
	distutils_src_prepare

	# Disable experimental exiv2 parser which fails to build.
	sed -e "s/-lexiv2/&_nonexistent/" -i setup.py || die "sed setup.py failed"
}
