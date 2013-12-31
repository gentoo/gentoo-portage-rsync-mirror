# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kwalletd/kwalletd-4.12.0.ebuild,v 1.2 2013/12/23 07:55:00 johu Exp $

EAPI=5

KMNAME="kde-runtime"
inherit kde4-meta

DESCRIPTION="KDE Password Server"
KEYWORDS=" ~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="debug semantic-desktop"

DEPEND="
	semantic-desktop? (
		app-crypt/gpgme
		$(add_kdebase_dep kdepimlibs)
	)
"
RDEPEND="${DEPEND}"

PATCHES=( "${FILESDIR}/${P}-qgpgme.patch" )

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_find_package semantic-desktop Gpgme)
		$(cmake-utils_use_find_package semantic-desktop QGpgme)
	)

	kde4-base_src_configure
}
