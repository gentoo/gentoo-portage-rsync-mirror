# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libpagemaker/libpagemaker-9999.ebuild,v 1.1 2015/01/27 20:34:04 jlec Exp $

EAPI=5

AUTOTOOLS_AUTORECONF=true

inherit autotools-utils git-r3

DESCRIPTION="C++ Library that parses the file format of Aldus/Adobe PageMaker documents."
HOMEPAGE="https://wiki.documentfoundation.org/DLP/Libraries/${PN}"
SRC_URI=""
EGIT_REPO_URI="git://gerrit.libreoffice.org/${PN}.git"

LICENSE="MPL-2.0"
SLOT="0"
KEYWORDS=""
IUSE="debug doc tools static-libs"

RDEPEND="
	dev-libs/librevenge
	>=dev-libs/boost-1.47
	"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	doc? ( app-doc/doxygen )
"

src_configure() {
	local myeconfargs=(
		--docdir="${EPREFIX}/usr/share/doc/${PF}"
		--disable-werror
		$(use_enable tools)
		$(use_with doc docs)
		)
	autotools-utils_src_configure
}
