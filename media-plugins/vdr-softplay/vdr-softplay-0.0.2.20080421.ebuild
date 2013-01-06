# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-softplay/vdr-softplay-0.0.2.20080421.ebuild,v 1.3 2011/04/06 17:30:38 idl0r Exp $

inherit vdr-plugin versionator

MY_PV=$(get_version_component_range 4)
MY_P=${PN}-cvs-${MY_PV}

DESCRIPTION="VDR plugin: play media-files with vdr+vdr-softdevice as output device"
HOMEPAGE="http://softdevice.berlios.de/softplay/index.html"
SRC_URI="mirror://gentoo/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=media-video/vdr-1.3.20
	>=media-plugins/vdr-softdevice-0.2.3.20060814-r1
	>=virtual/ffmpeg-0.4.9_p20080326"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${MY_P#vdr-}

src_unpack() {
	vdr-plugin_src_unpack

	cd "${S}"
	# Inclusion of vdr-softdevice header-files from /usr/include/vdr-softdevice
	sed -i SoftHandles.h -e 's#../softdevice/softdevice.h#vdr-softdevice/softdevice.h#'

	# ffmpeg-header-directory
	sed -i Makefile -e 's#^LIBFFMPEG=.*$#LIBFFMPEG=/usr/include/ffmpeg#'

	epatch "${FILESDIR}/ffmpeg-linking.diff"
	epatch "${FILESDIR}/ffmpeg-0.4.9_p20080326-new_header.diff"
	epatch "${FILESDIR}/${P}-glibc-2.10.patch"
}
