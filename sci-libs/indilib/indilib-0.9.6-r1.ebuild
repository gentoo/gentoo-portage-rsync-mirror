# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/indilib/indilib-0.9.6-r1.ebuild,v 1.2 2014/02/24 01:10:39 phajdan.jr Exp $

EAPI=5

MY_PN="lib${PN/lib/}"

inherit cmake-utils udev

DESCRIPTION="INDI Astronomical Control Protocol library"
HOMEPAGE="http://www.indilib.org/"
SRC_URI="mirror://sourceforge/${PN/lib/}/${MY_PN}_${PV}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 x86"
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
	"${FILESDIR}/0.9.1-fix_symlinks.patch"
	"${FILESDIR}/${P}-underlinking.patch"
)

S=${WORKDIR}/${MY_PN}-${PV}

src_prepare() {
	cmake-utils_src_prepare

	sed -e "s|/etc/udev/rules.d|$(get_udevdir)|" \
		-i CMakeLists.txt || die
}

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_with nova)
	)
	cmake-utils_src_configure
}
