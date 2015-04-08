# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/teamspeak-client-bin/teamspeak-client-bin-3.0.13.1.ebuild,v 1.2 2015/03/21 18:41:22 jlec Exp $

EAPI="5"

inherit eutils unpacker

DESCRIPTION="TeamSpeak Client - Voice Communication Software"
HOMEPAGE="http://www.teamspeak.com/"
SRC_URI="
	amd64? ( http://ftp.4players.de/pub/hosted/ts3/releases/${PV}/TeamSpeak3-Client-linux_amd64-${PV/_/-}.run )
	x86? ( http://ftp.4players.de/pub/hosted/ts3/releases/${PV}/TeamSpeak3-Client-linux_x86-${PV/_/-}.run )"

LICENSE="teamspeak3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="alsa pulseaudio"

REQUIRED_USE="|| ( alsa pulseaudio )"

RDEPEND="
	dev-qt/qtcore:4
	dev-qt/qtgui:4[accessibility,xinerama]
	dev-qt/qtsql:4
	sys-libs/glibc
	sys-libs/zlib
	alsa? ( media-libs/alsa-lib )
	pulseaudio? ( media-sound/pulseaudio )"

RESTRICT="fetch mirror strip"

S="${WORKDIR}"

pkg_nofetch() {
	elog "Please download ${A}"
	elog "from ${HOMEPAGE}?page=downloads and place this"
	elog "file in ${DISTDIR}"
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
	insinto /opt/teamspeak3-client
	doins -r *

	fperms +x /opt/teamspeak3-client/ts3client

	dobin "${FILESDIR}/teamspeak3"

	make_desktop_entry teamspeak3 TeamSpeak3 \
		"/opt/teamspeak3-client/pluginsdk/docs/client_html/images/logo.png" \
		Network
}
