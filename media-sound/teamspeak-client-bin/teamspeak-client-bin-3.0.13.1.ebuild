# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/teamspeak-client-bin/teamspeak-client-bin-3.0.13.1.ebuild,v 1.1 2013/11/09 18:44:21 tomwij Exp $

EAPI="5"

inherit eutils unpacker

DESCRIPTION="TeamSpeak Client - Voice Communication Software"
HOMEPAGE="http://www.teamspeak.com/"
LICENSE="teamspeak3"

SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="fetch mirror strip"
IUSE="alsa pulseaudio"

REQUIRED_USE="|| ( alsa pulseaudio )"

SRC_URI="amd64? ( http://ftp.4players.de/pub/hosted/ts3/releases/${PV}/TeamSpeak3-Client-linux_amd64-${PV/_/-}.run )
	x86? ( http://ftp.4players.de/pub/hosted/ts3/releases/${PV}/TeamSpeak3-Client-linux_x86-${PV/_/-}.run )"

RDEPEND="dev-qt/qtcore:4
	dev-qt/qtgui:4[accessibility,xinerama]
	dev-qt/qtsql:4
	sys-libs/glibc
	sys-libs/zlib

	alsa? ( media-libs/alsa-lib )
	pulseaudio? ( media-sound/pulseaudio )"

S="${WORKDIR}"

pkg_nofetch() {
	if use amd64 ; then
		einfo "Please download TeamSpeak3-Client-linux_amd64-${PV/_/-}.run"
	elif use x86 ; then
		einfo "Please download TeamSpeak3-Client-linux_x86-${PV/_/-}.run"
	fi
	einfo "from ${HOMEPAGE}?page=downloads and place this"
	einfo "file in ${DISTDIR}"
}

src_prepare() {
	# Remove the qt-libraries as they just cause trouble with the system's Qt, see bug #328807.
	rm libQt* || die "Couldn't remove bundled Qt libraries."

	# Remove unwanted soundbackends.
	if ! use alsa ; then
		rm soundbackends/libalsa* || die
	fi

	if ! use pulseaudio ; then
		rm soundbackends/libpulseaudio* || die
	fi

	# Rename the tsclient to its shorter version, required by the teamspeak3 script we install.
	mv ts3client_linux_* ts3client || die "Couldn't rename ts3client to its shorter version."
}

src_install() {
	dodir /opt/teamspeak3-client
	insinto /opt/teamspeak3-client
	doins -r *

	fperms +x /opt/teamspeak3-client/ts3client

	exeinto /usr/bin
	doexe "${FILESDIR}/teamspeak3"

	make_desktop_entry teamspeak3 TeamSpeak3 \
		"/opt/teamspeak3-client/pluginsdk/docs/client_html/images/logo.png" \
		Network
}
