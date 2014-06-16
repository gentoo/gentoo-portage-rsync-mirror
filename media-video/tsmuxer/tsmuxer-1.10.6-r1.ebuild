# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/tsmuxer/tsmuxer-1.10.6-r1.ebuild,v 1.11 2014/06/16 21:14:18 mgorny Exp $

EAPI=5

inherit eutils base qt4-r2

DESCRIPTION="Utility to create and demux TS and M2TS files"
HOMEPAGE="http://www.smlabs.net/en/products/tsmuxer/"
SRC_URI="http://www.smlabs.net/tsMuxer/tsMuxeR_shared_${PV}.tar.gz
	http://gentoo.sbriesen.de/distfiles/tsmuxer-icon.png"
LICENSE="SmartLabs"
SLOT="0"

KEYWORDS="~amd64 ~x86"
IUSE="qt4 linguas_ru"

QA_FLAGS_IGNORED="opt/${PN}/bin/tsMuxeR opt/${PN}/bin/tsMuxerGUI"

DEPEND="|| (
	>=app-arch/upx-ucl-3.01
	>=app-arch/upx-bin-3.01
)"
RDEPEND="
	x86? (
		media-libs/freetype:2
		qt4? (
			dev-libs/glib:2
			dev-qt/qtcore:4
			dev-qt/qtgui:4
			media-libs/fontconfig
			x11-libs/libICE
			x11-libs/libSM
			x11-libs/libX11
			x11-libs/libXext
			x11-libs/libXrender
		)
	)
	amd64? (
		|| (
			media-libs/freetype:2[abi_x86_32(-)]
			app-emulation/emul-linux-x86-xlibs[-abi_x86_32(-)]
		)
		qt4? (
			|| (
				app-emulation/emul-linux-x86-xlibs[-abi_x86_32(-)]
				(
					media-libs/fontconfig[abi_x86_32(-)]
					x11-libs/libICE[abi_x86_32(-)]
					x11-libs/libSM[abi_x86_32(-)]
					x11-libs/libX11[abi_x86_32(-)]
					x11-libs/libXext[abi_x86_32(-)]
					x11-libs/libXrender[abi_x86_32(-)]
				)
			)
			|| (
				app-emulation/emul-linux-x86-baselibs[-abi_x86_32(-)]
				(
					dev-libs/glib:2[abi_x86_32(-)]
					media-libs/libpng:1.2[abi_x86_32(-)]
					sys-libs/zlib[abi_x86_32(-)]
				)
			)
			|| (
				(
					dev-qt/qtcore:4[abi_x86_32(-)]
					dev-qt/qtgui:4[abi_x86_32(-)]
				)
				app-emulation/emul-linux-x86-qtlibs[-abi_x86_32(-)]
			)
		)
	)"

# cli is linked to freetype, when it will be fixed,
# we will remove app-emulation/emul-linux-x86-xlibs dep.

S="${WORKDIR}"

src_prepare() {
	upx -d tsMuxeR tsMuxerGUI || die
}

src_install() {
	dodir /opt/bin
	exeinto /opt/${PN}/bin

	doexe tsMuxeR
	dosym ../${PN}/bin/tsMuxeR /opt/bin/tsMuxeR

	if use qt4; then
		doexe tsMuxerGUI
		dosym ../${PN}/bin/tsMuxerGUI /opt/bin/tsMuxerGUI
		newicon "${DISTDIR}/${PN}-icon.png" "${PN}.png"
		make_desktop_entry tsMuxerGUI "tsMuxeR GUI" "${PN}" "Qt;AudioVideo;Video"
	fi

	use linguas_ru && dodoc readme.rus.txt
}
