# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/libvisual-plugins/libvisual-plugins-0.4.0-r2.ebuild,v 1.22 2013/02/02 22:57:27 ago Exp $

EAPI=4
inherit autotools eutils

PATCHLEVEL=4

DESCRIPTION="collection of visualization plugins for use with the libvisual framework"
HOMEPAGE="http://libvisual.sourceforge.net/"
SRC_URI="mirror://sourceforge/libvisual/${P}.tar.gz
	mirror://gentoo/${P}-patches-${PATCHLEVEL}.tar.bz2
	mirror://gentoo/${P}-m4-1.tar.bz2"

LICENSE="GPL-2"
SLOT="0.4"
KEYWORDS="~alpha amd64 ~arm hppa ~ia64 ~mips ppc ppc64 ~sparc x86 ~amd64-fbsd ~x86-fbsd"
IUSE="alsa debug gtk jack mplayer opengl"

RDEPEND="media-libs/fontconfig
	~media-libs/libvisual-${PV}
	x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXrender
	alsa? ( media-libs/alsa-lib )
	gtk? ( x11-libs/gtk+:2 )
	jack? ( >=media-sound/jack-audio-connection-kit-0.109 )
	opengl? (
		virtual/glu
		virtual/opengl
	)"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	x11-libs/libXt"

DOCS="AUTHORS ChangeLog NEWS README TODO"

src_prepare() {
	EPATCH_SUFFIX=patch epatch "${WORKDIR}"/patches
	AT_M4DIR=${WORKDIR}/m4 eautoreconf

	sed -i -e "s:@MKINSTALLDIRS@:${S}/mkinstalldirs:" po/Makefile.* || die
}

src_configure() {
	econf \
		--disable-esd \
		$(use_enable jack) \
		$(use_enable gtk gdkpixbuf-plugin) \
		--disable-gstreamer-plugin \
		$(use_enable alsa) \
		$(use_enable mplayer) \
		$(use_enable debug inputdebug) \
		$(use_enable opengl gltest) \
		$(use_enable opengl nastyfft) \
		$(use_enable opengl madspin) \
		$(use_enable opengl flower) \
		$(use_enable debug)
}

src_install() {
	default
	find "${ED}"/usr -type f -name '*.la' -exec rm -f {} +
}
