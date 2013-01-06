# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-image/vdr-image-0.3.0.ebuild,v 1.11 2012/05/05 08:27:20 jdhore Exp $

EAPI="3"

inherit vdr-plugin eutils flag-o-matic

VERSION="678" #every bump, new version

DESCRIPTION="VDR plugin: display of digital images, like jpeg, tiff, png, bmp"
HOMEPAGE="http://projects.vdr-developer.org/projects/plg-image"
SRC_URI="mirror://vdr-developerorg/${VERSION}/${P}.tar.gz"

KEYWORDS="amd64 x86"
SLOT="0"
LICENSE="GPL-2"
IUSE="exif"

COMMON_DEPEND=">=media-video/vdr-1.5.8
	>=virtual/ffmpeg-0.4.8_p20080326
	>=media-libs/netpbm-10.0
	exif? ( media-libs/libexif )"

DEPEND="${COMMON_DEPEND}
	virtual/pkgconfig"

RDEPEND="${COMMON_DEPEND}
	>=media-tv/gentoo-vdr-scripts-0.2.2"

VDR_RCADDON_FILE="${FILESDIR}/rc-addon-0.3.0.sh"
BUILD_PARAMS="-j1"

src_prepare() {
	vdr-plugin_src_prepare

	epatch "${FILESDIR}/${P}-gentoo.diff"

	use !exif && sed -i "s:#WITHOUT_LIBEXIF:WITHOUT_LIBEXIF:" Makefile

	if has_version "<=virtual/ffmpeg-0.4.9_p20061016"; then
		BUILD_PARAMS="${BUILD_PARAMS} WITHOUT_SWSCALER=1"
	fi

	# UINT64_C is needed by ffmpeg headers
	append-flags -D__STDC_CONSTANT_MACROS
}

src_install() {
	vdr-plugin_src_install

	insinto /etc/vdr/imagecmds
	newins examples/imagecmds.conf imagecmds.example.conf
	newins examples/imagecmds.conf.DE imagecmds.example.conf.de

	insinto /etc/vdr/plugins/image
	doins examples/imagesources.conf

	into /usr/share/vdr/image
	dobin scripts/imageplugin.sh
	newbin scripts/mount.sh mount-image.sh
}
