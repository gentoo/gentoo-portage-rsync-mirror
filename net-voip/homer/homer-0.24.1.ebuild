# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-voip/homer/homer-0.24.1.ebuild,v 1.1 2012/12/23 17:50:07 hwoarang Exp $

EAPI=4

inherit eutils multilib

DESCRIPTION="Homer Conferencing (short: Homer) is a free SIP softphone with advanced audio and video support."
HOMEPAGE="http://www.homer-conferencing.com"

MY_PN="Homer-Conferencing"
MY_BIN="Homer"

if [[ ${PV} == *9999* ]]; then
	inherit git-2
	EGIT_REPO_URI="git://github.com/${MY_PN}/${MY_PN}.git"
	KEYWORDS=""
else
	SRC_URI="https://github.com/${MY_PN}/${MY_PN}/archive/V${PV}.tar.gz -> ${PN}-${PV}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-2"
SLOT="0"
IUSE=""

DEPEND=">=dev-libs/openssl-1.0
	media-libs/alsa-lib
	media-libs/libsdl[X,audio,video,alsa]
	media-libs/portaudio[alsa]
	media-libs/sdl-mixer
	media-libs/sdl-sound
	media-libs/x264
	net-libs/sofia-sip
	virtual/ffmpeg[X]
	x11-libs/qt-core:4
	x11-libs/qt-gui:4
	x11-libs/qt-multimedia:4
	x11-libs/qt-webkit:4"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_PN}-${PV}"

src_compile() {
	emake -C HomerBuild default \
		INSTALL_PREFIX=/usr/bin \
		INSTALL_LIBDIR=/usr/$(get_libdir) \
		INSTALL_DATADIR=/usr/share/${PN} \
		VERBOSE=1
}

src_install() {
	emake -C HomerBuild install \
		DESTDIR="${D}" \
		VERBOSE=1

	# Create .desktop entry
	doicon ${MY_BIN}/${MY_BIN}.png
	make_desktop_entry "${MY_BIN}" "${MY_PN}" "${MY_BIN}" "Network;InstantMessaging;Telephony;VideoConference"
}
