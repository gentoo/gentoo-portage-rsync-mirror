# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/teamspeak-client-bin/teamspeak-client-bin-3.0.6.ebuild,v 1.1 2012/05/09 11:49:45 polynomial-c Exp $

EAPI=1

inherit eutils unpacker

DESCRIPTION="TeamSpeak Client - Voice Communication Software"
HOMEPAGE="http://teamspeak.com/"
LICENSE="teamspeak3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="strip"
PROPERTIES="interactive"

SRC_URI="
	amd64? ( http://ftp.4players.de/pub/hosted/ts3/releases/${PV}/TeamSpeak3-Client-linux_amd64-${PV/_/-}.run )
	x86? ( http://ftp.4players.de/pub/hosted/ts3/releases/${PV}/TeamSpeak3-Client-linux_x86-${PV/_/-}.run )
"

DEPEND=""
RDEPEND="${DEPEND}
		x11-libs/qt-gui:4
		>=x11-libs/libXinerama-1.0.2"

src_install() {
	local dest="${D}/opt/teamspeak3-client"

	mkdir -p "${dest}"

	# remove the qt-libraries as they just cause trouble with the system's Qt
	# see bug #328807
	rm "${WORKDIR}"/libQt* || die

	cp -R "${WORKDIR}/"* "${dest}/" || die

	exeinto /usr/bin
	doexe "${FILESDIR}/teamspeak3"

	mv "${dest}/ts3client_linux_"* "${dest}/ts3client"

	make_desktop_entry teamspeak3 TeamSpeak3 \
		"/opt/teamspeak3-client/gfx/default/24x24_connect.png" \
		Network
}
