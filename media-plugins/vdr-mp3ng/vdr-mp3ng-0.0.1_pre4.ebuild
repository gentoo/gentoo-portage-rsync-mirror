# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-mp3ng/vdr-mp3ng-0.0.1_pre4.ebuild,v 1.7 2009/08/09 19:29:42 ssuominen Exp $

inherit vdr-plugin eutils

MY_PV=0.9.13-MKIV-pre3
MY_P=${PN}-${MY_PV}

S=${WORKDIR}/mp3ng-0.9.13-MKIV-pre3

DESCRIPTION="Plugin to play mp3 and ogg on VDR"
HOMEPAGE="http://www.glaserei-franz.de/VDR/Moronimo2/vdrplugins.htm"
SRC_URI="http://www.glaserei-franz.de/VDR/Moronimo2/downloads/${MY_P}.tar.gz
		mirror://gentoo/${PN}-pictures-0.0.1.tar.gz
		mirror://gentoo/${P}-span-0.0.3.diff.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE="vorbis oss imagemagick"

DEPEND=">=media-video/vdr-1.2.6
		media-libs/libmad
		media-libs/libid3tag
		sys-libs/zlib
		media-libs/libsndfile
		vorbis? ( media-libs/libvorbis )
		imagemagick? ( media-gfx/imagemagick )
		!imagemagick? ( media-libs/imlib2 )"

src_unpack() {
	vdr-plugin_src_unpack

	epatch "${FILESDIR}/${P}-gentoo.diff"
	epatch "${FILESDIR}/${P}-gcc4.diff"
	epatch "${DISTDIR}/${P}-span-0.0.3.diff.tar.gz"
	epatch "${FILESDIR}/${P}-vdr-1.5.1.diff"
	epatch "${FILESDIR}/${P}-glibc-2.10.patch"

	use !vorbis && sed -i "s:#WITHOUT_LIBVORBISFILE:WITHOUT_LIBVORBISFILE:" Makefile
	use oss && sed -i "s:#WITH_OSS_OUTPUT:WITH_OSS_OUTPUT:" Makefile
	use imagemagick && sed -i Makefile -e "s:HAVE_IMLIB2:#HAVE_IMLIB2:" \
		-e "s:#HAVE_MAGICK:HAVE_MAGICK:"

	has_version ">=media-video/vdr-1.3.37" && epatch "${FILESDIR}/${P}-1.3.37.diff"
	has_version ">=media-gfx/imagemagick-6.4" && epatch "${FILESDIR}/imagemagick-6.4.x.diff"
}

src_install() {
	vdr-plugin_src_install

	insinto /etc/vdr/plugins/mp3ng
	doins	"${FILESDIR}/mp3ngsources"

	insinto /usr/share/vdr/mp3ng
	doins "${WORKDIR}/${PN}-pictures-0.0.1"/*.jpg
	doins "${S}/images/mp3MKIV-spectrum-analyzer-bg.png"

	newbin examples/mount.sh.example mount-mp3ng.sh

	dodoc HISTORY MANUAL README README-MORONIMO examples/network.sh.example
}
