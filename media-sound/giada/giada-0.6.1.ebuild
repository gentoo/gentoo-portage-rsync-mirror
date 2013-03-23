# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/giada/giada-0.6.1.ebuild,v 1.1 2013/03/23 02:33:52 radhermit Exp $

EAPI=5

inherit flag-o-matic eutils autotools

DESCRIPTION="A free, minimal, hardcore audio tool for djs and live performers"
HOMEPAGE="http://www.giadamusic.com/"
SRC_URI="http://www.giadamusic.com/download-action.php?os=source&version=${PV} -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+alsa jack pulseaudio"
REQUIRED_USE="|| ( alsa jack pulseaudio )"

RDEPEND="media-libs/libsndfile
	media-libs/libsamplerate
	media-libs/rtaudio[alsa?,jack?,pulseaudio?]
	x11-libs/fltk:1
	x11-libs/libXpm"
DEPEND="${RDEPEND}"

S=${WORKDIR}

src_prepare() {
	epatch "${FILESDIR}"/${PN}-0.5.4-flags.patch
	epatch "${FILESDIR}"/${PN}-0.5.8-configure.patch
	eautoreconf
}

src_configure() {
	append-cppflags -I/usr/include/fltk-1
	append-ldflags -L/usr/$(get_libdir)/fltk-1

	econf \
		--target=linux \
		$(use_enable alsa) \
		$(use_enable jack) \
		$(use_enable pulseaudio pulse)
}
