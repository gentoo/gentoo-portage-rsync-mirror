# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/leechcraft-monocle/leechcraft-monocle-0.5.90-r1.ebuild,v 1.3 2013/02/16 21:28:27 ago Exp $

EAPI="4"

inherit leechcraft

DESCRIPTION="Monocle, the modular document viewer for LeechCraft."

SLOT="0"
KEYWORDS="amd64 x86"
IUSE="+djvu debug +fb2 +pdf +spectre"

DEPEND="~net-misc/leechcraft-core-${PV}
	pdf? ( app-text/poppler[qt4] )
	djvu? ( app-text/djvu )
	spectre? ( app-text/libspectre )
"
RDEPEND="${DEPEND}"

src_configure() {
	local mycmakeargs="
		$(cmake-utils_use_enable djvu MONOCLE_SEEN)
		$(cmake-utils_use_enable fb2 MONOCLE_FXB)
		$(cmake-utils_use_enable pdf MONOCLE_PDF)
		$(cmake-utils_use_enable spectre MONOCLE_POSTRUS)"

	cmake-utils_src_configure
}
