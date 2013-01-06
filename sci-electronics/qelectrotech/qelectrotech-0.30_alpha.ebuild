# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-electronics/qelectrotech/qelectrotech-0.30_alpha.ebuild,v 1.1 2012/05/27 09:50:31 hwoarang Exp $

EAPI="4"

LANGS="ar ca cs de en es fr hr it pl pt ro ru sl"
inherit qt4-r2 versionator

MY_PV="${PV/_alpha/a}"
MY_P="${PN}-${MY_PV/30a/3a}-src"

DESCRIPTION="Qt4 application to design electric diagrams"
HOMEPAGE="http://www.qt-apps.org/content/show.php?content=90198"
SRC_URI="http://download.tuxfamily.org/qet/tags/20120513/${MY_P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug doc"

RDEPEND="x11-libs/qt-gui:4
	x11-libs/qt-svg:4"
DEPEND="${RDEPEND}
	doc? ( app-doc/doxygen )"

S="${WORKDIR}"/${MY_P}
DOCS="CREDIT ChangeLog README"

PATCHES=( "${FILESDIR}/${PN}-0.3-fix-paths.patch" )

src_install() {
	qt4-r2_src_install
	if use doc; then
		doxygen Doxyfile || die
		dohtml -r doc/html/*
	fi
	for x in ${LANGS}; do
		if ! has ${x} ${LINGUAS}; then
			find "${D}"/usr/share/${PN}/lang/ -name "*${x}*" -exec rm {} \;
		fi
	done
}
