# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-leechcraft/lc-monocle/lc-monocle-0.6.0.ebuild,v 1.1 2013/09/24 15:48:06 maksbotan Exp $

EAPI="5"

inherit leechcraft

DESCRIPTION="Monocle, the modular document viewer for LeechCraft"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug +djvu doc +fb2 +pdf +spectre"

RDEPEND="~app-leechcraft/lc-core-${PV}
	pdf? ( app-text/poppler[qt4] )
	djvu? ( app-text/djvu )
	spectre? ( app-text/libspectre )"
DEPEND="${RDEPEND}
	doc? ( app-doc/doxygen[dot] )"

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_enable djvu MONOCLE_SEEN)
		$(cmake-utils_use_with doc DOCS)
		$(cmake-utils_use_enable fb2 MONOCLE_FXB)
		$(cmake-utils_use_enable pdf MONOCLE_PDF)
		$(cmake-utils_use_enable spectre MONOCLE_POSTRUS)
	)
	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install
	use doc && dohtml -r "${CMAKE_BUILD_DIR}"/out/html/*
}
