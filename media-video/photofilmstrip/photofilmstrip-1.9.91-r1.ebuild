# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/photofilmstrip/photofilmstrip-1.9.91-r1.ebuild,v 1.1 2013/06/15 15:41:28 floppym Exp $

EAPI="5"
PYTHON_COMPAT=( python2_{6,7} )
PYTHON_REQ_USE="sqlite"

inherit distutils-r1

DESCRIPTION="Movie slideshow creator using Ken Burns effect"
HOMEPAGE="http://www.photofilmstrip.org"
SRC_URI="mirror://sourceforge/photostoryx/${PN}/${PV}-unstable/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"

KEYWORDS="~amd64 ~x86"
IUSE="cairo sdl"

RDEPEND="dev-python/wxpython:2.8[cairo?,${PYTHON_USEDEP}]
	virtual/python-imaging[${PYTHON_USEDEP}]
	media-video/mplayer[encode]
	sdl? ( dev-python/pygame[${PYTHON_USEDEP}] )"

DEPEND="${RDEPEND}"

# Fix bug #472774 (https://bugs.gentoo.org/show_bug.cgi?id=472774)
PATCHES=(
	"${FILESDIR}/${P}-PIL_modules_imports_fix.patch"
)

DOCS=( CHANGES COPYING README )

src_prepare() {
	# Remove unneeded icon resources update needing running X
	sed -i \
        -e '/self\._make_resources\(\)/d' \
        setup.py

	# Fix desktop file entry
	sed -i \
        -e '/^Version.*/d' \
        data/photofilmstrip.desktop

	distutils-r1_src_prepare
}

src_install() {
	# Do not compress the apps help files
	docompress -x  /usr/share/doc/${PN}

	distutils-r1_src_install
}
