# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/teamspeak-server-bin/teamspeak-server-bin-3.0.7.1.ebuild,v 1.1 2013/04/25 18:11:05 tomwij Exp $

EAPI=5

inherit eutils systemd user

DESCRIPTION="TeamSpeak Server - Voice Communication Software"
HOMEPAGE="http://www.teamspeak.com/"
LICENSE="teamspeak3 GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="fetch mirror strip"

SRC_URI="amd64? ( http://ftp.4players.de/pub/hosted/ts3/releases/${PV}/teamspeak3-server_linux-amd64-${PV}.tar.gz )
	x86? ( http://ftp.4players.de/pub/hosted/ts3/releases/${PV}/teamspeak3-server_linux-x86-${PV}.tar.gz )"

S="${WORKDIR}/teamspeak3-server_linux-${ARCH}"

pkg_nofetch() {
	if use amd64 ; then
		einfo "Please download teamspeak3-server_linux-amd64-${PV}.tar.gz"
	elif use x86 ; then
		einfo "Please download teamspeak3-server_linux-x86-${PV}.tar.gz"
	fi
	einfo "from ${HOMEPAGE}?page=downloads and place this"
	einfo "file in ${DISTDIR}"
}

pkg_setup() {
	enewuser teamspeak3
}

src_install() {
	# Install TeamSpeak 3 server into /opt/teamspeak3-server.
	local dest="${D}/opt/teamspeak3-server"
	mkdir -p "${dest}" || die "Can't create ${dest} directory."
	cp -R "${WORKDIR}/teamspeak3-server_linux-"*/* "${dest}/" || die "Can't copy files to ${dest}."
	mv "${dest}/ts3server_linux_"* "${dest}/ts3server-bin" || die "Can't rename server file to t3server-bin."

	# Install wrapper.
	exeinto /usr/sbin
	doexe "${FILESDIR}/ts3server"

	# Install the runtime FS layout.
	insinto /etc/teamspeak3-server
	doins "${FILESDIR}/server.conf"
	keepdir /{etc,var/{lib,log,run}}/teamspeak3-server

	# Install the init script and systemd unit.
	newinitd "${FILESDIR}/${P}.rc" teamspeak3-server
	systemd_dounit "${FILESDIR}/systemd/teamspeak3.service"
	systemd_dotmpfilesd "${FILESDIR}/systemd/teamspeak3.conf"

	# Fix up permissions.
	fowners teamspeak3 /{etc,var/{lib,log,run}}/teamspeak3-server
	fperms 700 /{etc,var/{lib,log,run}}/teamspeak3-server

	fowners teamspeak3 /opt/teamspeak3-server
	fperms 755 /opt/teamspeak3-server
}
