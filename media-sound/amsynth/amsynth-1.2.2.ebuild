# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/amsynth/amsynth-1.2.2.ebuild,v 1.4 2012/05/05 08:05:35 mgorny Exp $

EAPI=2
MY_P=${P/ams/amS}
inherit autotools eutils

DESCRIPTION="Virtual analogue synthesizer."
HOMEPAGE="http://amsynthe.sourceforge.net/"
SRC_URI="mirror://sourceforge/amsynthe/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="alsa debug jack oss sndfile"

RDEPEND="dev-cpp/gtkmm:2.4
	sndfile? ( >=media-libs/libsndfile-1 )
	alsa? ( media-libs/alsa-lib
		media-sound/alsa-utils )
	jack? ( media-sound/jack-audio-connection-kit )"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

S=${WORKDIR}/${MY_P}

src_prepare() {
	epatch "${FILESDIR}"/${P}-asneeded.patch
	eautoreconf
}

src_configure() {
	econf \
		$(use_with oss) \
		$(use_with alsa) \
		$(use_with jack) \
		$(use_with sndfile) \
		$(use_enable debug)
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS README
}

pkg_postinst() {
	elog
	elog "amSynth has been installed normally. If you would like to use"
	elog "the virtual keyboard option, then do:"
	elog "# emerge vkeybd"
	elog "and make sure you emerged amSynth with alsa support (USE=alsa)"
	elog
}
