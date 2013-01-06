# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/giada/giada-0.5.4.ebuild,v 1.1 2012/11/27 07:38:44 radhermit Exp $

EAPI=5

inherit flag-o-matic eutils autotools

DESCRIPTION="A free, minimal, hardcore audio tool for djs and live performers"
HOMEPAGE="http://www.monocasual.com/giada/"
SRC_URI="http://www.monocasual.com/giada/download.php?dist=source&file=${PN}_${PV}_src.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+alsa jack pulseaudio"
REQUIRED_USE="|| ( alsa jack pulseaudio )"

RDEPEND="media-libs/libsndfile
	media-libs/rtaudio[alsa?,jack?,pulseaudio?]
	x11-libs/fltk:1
	x11-libs/libXpm"
DEPEND="${RDEPEND}"

S=${WORKDIR}

src_prepare() {
	epatch "${FILESDIR}"/${P}-flags.patch
	epatch "${FILESDIR}"/${P}-configure.patch
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
