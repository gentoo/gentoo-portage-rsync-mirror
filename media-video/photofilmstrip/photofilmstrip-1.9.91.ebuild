# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/photofilmstrip/photofilmstrip-1.9.91.ebuild,v 1.1 2013/01/26 18:00:25 hwoarang Exp $

EAPI="5"
PYTHON_DEPEND="2"
RESTRICT_PYTHON_ABIS="3.*"
PYTHON_USE_WITH="sqlite"

inherit python distutils

DESCRIPTION="Movie slideshow creator using Ken Burns effect"
HOMEPAGE="http://www.photofilmstrip.org"
SRC_URI="mirror://sourceforge/photostoryx/${PN}/${PV}-unstable/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"

KEYWORDS="~amd64 ~x86"
IUSE="cairo sdl"

RDEPEND="dev-python/wxpython:2.8[cairo?]
	dev-python/imaging
	media-video/mplayer[encode]
	sdl? ( dev-python/pygame )"

DEPEND="${RDEPEND}"

DOCS="CHANGES COPYING README"

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_prepare() {
	# Remove unneeded icon resources update needing running X
	sed -i \
        -e '/self\._make_resources\(\)/d' \
        setup.py

	# Fix desktop file entry
	sed -i \
        -e '/^Version.*/d' \
        data/photofilmstrip.desktop

	python_clean_py-compile_files
	distutils_src_prepare
}

src_install() {
	# Do not compress the apps help files
	docompress -x  /usr/share/doc/${PN}

	distutils_src_install
}
