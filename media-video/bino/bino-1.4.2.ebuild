# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/bino/bino-1.4.2.ebuild,v 1.1 2013/04/21 12:38:44 lu_zero Exp $

EAPI=4

inherit autotools-utils flag-o-matic

DESCRIPTION="Stereoscopic and multi-display media player"
HOMEPAGE="http://bino3d.org/"
SRC_URI="http://download.savannah.gnu.org/releases/${PN}/${P}.tar.xz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc lirc"

IUSE_VIDEO_CARDS="
	video_cards_nvidia"
IUSE+="${IUSE_VIDEO_CARDS}"

LANGS="en bg de fr ru"
for X in ${LANGS} ; do
	IUSE+=" linguas_${X}"
done

RDEPEND=">=media-libs/glew-1.6.0
	media-libs/openal
	dev-qt/qtgui:4
	dev-qt/qtcore:4
	dev-qt/qtopengl:4
	>=media-libs/libass-0.9.9
	>=virtual/ffmpeg-0.6.90
	lirc? ( app-misc/lirc )
	video_cards_nvidia? ( media-video/nvidia-settings )
	virtual/libintl"

DEPEND="${RDEPEND}
	sys-devel/gettext
	virtual/pkgconfig"

DOCS=( AUTHORS ChangeLog NEWS README README.Linux )

src_configure() {
	local myeconfargs=(
		$(use_with video_cards_nvidia xnvctrl)
		$(use_with lirc liblircclient)
		--without-equalizer
		--htmldir=/usr/share/doc/${PF}/html
	)
    if use lirc; then
	    export liblircclient_CFLAGS="-I/usr/include/lirc"
		export liblircclient_LIBS="-llirc_client"
	fi
	if use video_cards_nvidia; then
		append-cppflags "-I/usr/include/NVCtrl"
	fi
	# Fix a compilation error because of a multiple definitions in glew
	append-ldflags "-zmuldefs"

	autotools-utils_src_configure
}

src_install() {
	autotools-utils_src_install

	use doc || ( rm -rf "${D}"/usr/share/doc/${PF}/html && dohtml "${FILESDIR}/${PN}.html" )
}
