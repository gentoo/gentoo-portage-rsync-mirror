# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/indilib/indilib-0.9.1.ebuild,v 1.3 2012/08/20 17:08:21 jer Exp $

EAPI=4

MY_PN="lib${PN/lib/}"

inherit cmake-utils

DESCRIPTION="INDI Astronomical Control Protocol library"
HOMEPAGE="http://indi.sourceforge.net/index.php/Main_Page"
SRC_URI="mirror://sourceforge/${PN/lib/}/${MY_PN}_${PV}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ~ppc64 x86"
IUSE="nova v4l"

RDEPEND="
	>=sci-libs/cfitsio-3.140
	sys-libs/zlib
	virtual/libusb:0
	nova? ( >=sci-libs/libnova-0.12.1 )
"
DEPEND="${RDEPEND}
	v4l? ( >=sys-kernel/linux-headers-2.6 )
"

DOCS=( AUTHORS ChangeLog README README.drivers TODO )

PATCHES=(
	"${FILESDIR}/${PV}-fix_symlinks.patch"
)

S=${WORKDIR}/${MY_PN}-${PV}

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_with nova)
	)
	cmake-utils_src_configure
}
