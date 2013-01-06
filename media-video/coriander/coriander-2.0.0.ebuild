# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/coriander/coriander-2.0.0.ebuild,v 1.3 2012/05/05 08:58:55 jdhore Exp $

inherit eutils

MY_P=${P/_/-}

DESCRIPTION="A Gnome2 GUI for firewire camera control and capture"
HOMEPAGE="http://sourceforge.net/projects/coriander/"

SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE=""

S=${WORKDIR}/${MY_P}

# ffmpeg? ( media-video/ffmpeg ) left out, because ffmpeg support is in
# development
RDEPEND=">=media-libs/libdc1394-2.0.0
	media-libs/libsdl
	gnome-base/libgnomeui
	gnome-base/libbonoboui
	gnome-base/libgnomecanvas
	gnome-base/libgnome
	gnome-base/orbit"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_unpack() {
	unpack ${A}
	cd "${S}"
}

src_compile() {
	export SSE_CFLAGS="${CFLAGS}"
	# ffmpeg support is currently disabled in coriander-2, so we leave out the
	# $(use_enable ffmpeg)
	econf || die "econf failed"
	emake SSE_CFLAGS="${CFLAGS}" || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"
	dodoc NEWS README AUTHORS
}
