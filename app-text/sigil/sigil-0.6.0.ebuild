# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/sigil/sigil-0.6.0.ebuild,v 1.3 2013/03/02 19:45:35 hwoarang Exp $

EAPI=4
CMAKE_BUILD_TYPE="Release"

inherit eutils cmake-utils

MY_P="Sigil-${PV}-Code"

DESCRIPTION="Sigil is a multi-platform WYSIWYG ebook editor for ePub format."
HOMEPAGE="http://code.google.com/p/sigil/"
SRC_URI="http://${PN}.googlecode.com/files/${MY_P}.zip"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	>=sys-libs/zlib-1.2.7[minizip]
	>=dev-libs/libpcre-8.31
	>=dev-libs/boost-1.49
	>=app-text/hunspell-1.3.2
	>=dev-libs/xerces-c-3.1.1
	>=dev-qt/qtwebkit-4.8:4
	>=dev-qt/qtsvg-4.8:4
	>=dev-qt/qtgui-4.8:4"
RDEPEND="${DEPEND}"

S="${WORKDIR}"

DOCS=( ChangeLog README )

src_prepare() {
	# use standard naming
	mv -f README.txt README
	mv -f ChangeLog.txt ChangeLog
	edos2unix ChangeLog README
}
