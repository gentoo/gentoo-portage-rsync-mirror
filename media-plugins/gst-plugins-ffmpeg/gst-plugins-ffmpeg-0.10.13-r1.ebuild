# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-ffmpeg/gst-plugins-ffmpeg-0.10.13-r1.ebuild,v 1.7 2012/12/02 23:08:35 eva Exp $

EAPI=4

inherit base eutils flag-o-matic

PD=${FILESDIR}/${PV}
MY_PN=${PN/-plugins}
MY_P=${MY_PN}-${PV}

# Create a major/minor combo for SLOT
PVP=(${PV//[-\._]/ })
SLOT=${PVP[0]}.${PVP[1]}
#SLOT=0.10

DESCRIPTION="FFmpeg based gstreamer plugin"
HOMEPAGE="http://gstreamer.freedesktop.org/modules/gst-ffmpeg.html"
SRC_URI="http://gstreamer.freedesktop.org/src/${MY_PN}/${MY_P}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="+orc hardened"

S=${WORKDIR}/${MY_P}

RDEPEND=">=media-libs/gstreamer-0.10.31
	>=media-libs/gst-plugins-base-0.10.31
	orc? ( >=dev-lang/orc-0.4.6 )"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

PATCHES=( "${FILESDIR}"/${PV}-gcc-4.7.patch )

src_configure() {
	append-flags -fno-strict-aliasing

	if ! use hardened; then
		econf $(use_enable orc)
	else
		# On hardened, we need to disable mmx and mmx2 to avoid TEXTRELs
		econf $(use_enable orc) \
			--with-ffmpeg-extra-configure='--disable-mmx --disable-mmx2'
	fi
}
