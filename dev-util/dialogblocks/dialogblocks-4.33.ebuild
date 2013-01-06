# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/dialogblocks/dialogblocks-4.33.ebuild,v 1.3 2012/09/24 00:44:25 vapier Exp $

EAPI=2

DESCRIPTION="GUI builder tool for wxWidgets"
HOMEPAGE="http://www.anthemion.co.uk/dialogblocks/"
SRC_URI="x86? ( http://www.anthemion.co.uk/${PN}/DialogBlocks-${PV}-i386.tar.gz )
	amd64? ( http://www.anthemion.co.uk/${PN}/DialogBlocks-${PV}-x86_64.tar.gz )"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="x11-libs/gtk+:2
	x11-libs/libXinerama
	x11-libs/libXxf86vm
	x11-libs/libSM
	=media-libs/libpng-1.2*
	=media-libs/jpeg-6*
	sys-libs/zlib
	x11-libs/libX11"

QA_PRESTRIPPED="opt/dialogblocks/dialogblocks"
QA_FLAGS_IGNORED="opt/dialogblocks/dialogblocks"

S=${WORKDIR}

src_install() {
	dodir /opt/dialogblocks
	tar -xzf DialogBlocksData.tar.gz -C "${D}/opt/dialogblocks" || die "failed to extract data from tarball"
	fowners -R root:root /opt/dialogblocks
	dosed 's:/usr/share/:/opt/:' /opt/dialogblocks/dialogblocks.desktop

	local i
	dosym /opt/dialogblocks/dialogblocks32x32.xpm /usr/share/pixmaps/dialogblocks.xpm
	for i in 32x32 48x48 128x128; do
	    dosym /opt/dialogblocks/appicons/dialogblocks${i}.png /usr/share/icons/hicolor/${i}/apps/dialogblocks.png
	done
	dosym /opt/dialogblocks/dialogblocks.desktop /usr/share/applications/dialogblocks.desktop
	newbin "${FILESDIR}/dialogblocks.sh" dialogblocks
}
