# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/libkdcraw/libkdcraw-4.10.5-r1.ebuild,v 1.5 2013/07/30 10:40:45 ago Exp $

EAPI=5

inherit kde4-base

DESCRIPTION="KDE digital camera raw image library wrapper"
KEYWORDS="amd64 ~arm ppc ~ppc64 x86 ~amd64-linux ~x86-linux"
IUSE="debug jasper"

DEPEND="
	>=media-libs/libraw-0.15:=
	virtual/jpeg
	jasper? ( media-libs/jasper )
"
RDEPEND="${DEPEND}"

PATCHES=( "${FILESDIR}/${PN}-4.10.5-extlibraw.patch" )

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_find_package jasper)
	)

	kde4-base_src_configure
}
