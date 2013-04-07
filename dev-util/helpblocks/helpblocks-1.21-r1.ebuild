# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/helpblocks/helpblocks-1.21-r1.ebuild,v 1.4 2013/04/07 08:43:56 ulm Exp $

EAPI=1

DESCRIPTION="HTML Help Editor for wxWidgets"
HOMEPAGE="http://www.helpblocks.com/"
SRC_URI="x86? ( http://www.helpblocks.com/HelpBlocks-${PV}-i386.tar.gz )
	amd64? ( http://www.helpblocks.com/HelpBlocks-${PV}-x86_64.tar.gz )"

SLOT="0"
LICENSE="as-is"
KEYWORDS="-* ~amd64 ~x86"
IUSE=""
RESTRICT="mirror bindist"

DEPEND=""
RDEPEND="x11-libs/gtk+:2
	x11-libs/libXinerama
	>=media-libs/libpng-1.2
	media-libs/jpeg
	>=media-libs/tiff-3"

S="${WORKDIR}"

RESTRICT="strip" # the helpblocks program is already stripped

src_install() {
	dodir /opt/helpblocks
	tar -xzf HelpBlocksData.tar.gz -C "${D}/opt/helpblocks" || die "failed to extract data from tarball"

	local i
	for i in 32x32 48x48 128x128; do
	    dosym /opt/helpblocks/appicons/helpblocks${i}.png /usr/share/icons/hicolor/${i}/apps/helpblocks.png
	done
	domenu "${FILESDIR}/helpblocks.desktop"
	newbin "${FILESDIR}/helpblocks.sh" helpblocks
}
