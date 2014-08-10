# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/opencc/opencc-0.4.3.ebuild,v 1.2 2014/08/10 17:51:21 slyfox Exp $

EAPI=5

inherit cmake-utils multilib eutils

DESCRIPTION="Libraries for conversion between Traditional and Simplified Chinese"
HOMEPAGE="http://code.google.com/p/opencc/"
SRC_URI="https://opencc.googlecode.com/files/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="+nls static-libs"

DEPEND="nls? ( sys-devel/gettext )"
RDEPEND="nls? ( virtual/libintl )"

DOCS="AUTHORS NEWS.md README.md"

src_configure() {
	local mycmakeargs=(
		"$(cmake-utils_use_enable nls GETTEXT)"
		-DCMAKE_INSTALL_LIBDIR="${EPREFIX}"/usr/$(get_libdir)
	)

	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install

	use static-libs || find "${ED}" -name '*.la' -o -name '*.a' -exec rm {} +
}
