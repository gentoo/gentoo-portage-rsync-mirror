# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-electronics/qelectrotech/qelectrotech-9999.ebuild,v 1.1 2013/06/02 20:26:55 hwoarang Exp $

EAPI="4"

LANGS="ar ca cs de en es fr hr it pl pt ro ru sl"
inherit qt4-r2 versionator

if [[ "${PV}" == "9999" ]]; then
	inherit subversion
	ESVN_REPO_URI="svn://svn.tuxfamily.org/svnroot/qet/qet/trunk"
	KEYWORDS=""
else
	MY_PV="${PV/_alpha/a}"
	MY_P="${PN}-${MY_PV/30a/3a}-src"
	SRC_URI="http://download.tuxfamily.org/qet/tags/20120513/${MY_P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
	S="${WORKDIR}"/${MY_P}
fi

DESCRIPTION="Qt4 application to design electric diagrams"
HOMEPAGE="http://www.qt-apps.org/content/show.php?content=90198"

LICENSE="GPL-3"
SLOT="0"
IUSE="debug doc"

RDEPEND="dev-qt/qtgui:4
	dev-qt/qtsvg:4"
DEPEND="${RDEPEND}
	doc? ( app-doc/doxygen )"

DOCS="CREDIT ChangeLog README"

PATCHES=( "${FILESDIR}/${PN}-0.3-fix-paths.patch" )

src_prepare() {
	[[ "${PV}" == "9999" ]] && subversion_src_prepare
	qt4-r2_src_prepare
}

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
