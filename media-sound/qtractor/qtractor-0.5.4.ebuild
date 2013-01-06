# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/qtractor/qtractor-0.5.4.ebuild,v 1.3 2012/05/05 08:47:48 mgorny Exp $

EAPI=2

inherit qt4-r2 flag-o-matic

DESCRIPTION="Qtractor is an Audio/MIDI multi-track sequencer."
HOMEPAGE="http://qtractor.sourceforge.net/"
SRC_URI="mirror://sourceforge/qtractor/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="debug dssi libsamplerate mad osc rubberband vorbis suil sse zlib"

RDEPEND=">=x11-libs/qt-core-4.2:4
	>=x11-libs/qt-gui-4.7:4[gtkstyle]
	media-libs/alsa-lib
	media-libs/libsndfile
	media-sound/jack-audio-connection-kit
	media-libs/ladspa-sdk
	dssi? ( media-libs/dssi )
	mad? ( media-libs/libmad )
	libsamplerate? ( media-libs/libsamplerate )
	media-libs/lilv
	osc? ( media-libs/liblo )
	rubberband? ( media-libs/rubberband )
	suil? ( media-libs/suil )
	vorbis? ( media-libs/libvorbis )
	zlib? ( sys-libs/zlib )"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

DOCS="README ChangeLog TODO AUTHORS"

src_configure() {
	econf \
		$(use_enable mad libmad) \
		$(use_enable libsamplerate) \
		$(use_enable vorbis libvorbis) \
		$(use_enable osc liblo) \
		--enable-ladspa \
		$(use_enable dssi) \
		--enable-lilv \
		$(use_enable rubberband librubberband) \
		$(use suil || echo " --disable-suil") \
		$(use_enable sse) \
		$(use_enable zlib libz) \
		$(use_enable debug)
	eqmake4 qtractor.pro -o qtractor.mak
}
