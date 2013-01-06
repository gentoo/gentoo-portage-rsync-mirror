# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-voip/openmcu/openmcu-2.2.1.ebuild,v 1.1 2009/02/13 05:22:23 darkside Exp $

EAPI="2"

inherit eutils

MY_PV=${PV//./_}
DESCRIPTION="Simple Multi Conference Unit using H.323"
# http://www.openh323.org/ looks dead
HOMEPAGE="http://sourceforge.net/projects/openh323/"
SRC_URI="mirror://sourceforge/openh323/${PN}-v${MY_PV}-src.tar.gz"

LICENSE="MPL-1.0"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="net-libs/openh323"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${PN}_v${MY_PV}

src_prepare() {
	# fix a compile error due to missing include
	epatch "${FILESDIR}"/${P}-deque.patch
	# set path for various files
	epatch "${FILESDIR}"/${P}-path.patch
}

src_compile() {
	OPENH323DIR=/usr/share/openh323 emake opt || die "emake failed"
}

src_install() {
	dosbin obj_*_*_*/${PN} || die "dosbin failed"

	keepdir /usr/share/${PN}/data /usr/share/${PN}/html

	# needed for daemon
	keepdir /var/log/${PN} /var/run/${PN}

	insinto /usr/share/${PN}/sounds
	doins *.wav || die "doins wav files failed"

	insinto /etc/${PN}
	doins server.pem || die "doins server.pem failed"
	doins "${FILESDIR}"/${PN}.ini || die "doins ini file failed"

	doman ${PN}.1 || die "doman failed"

	dodoc ChangeLog ReadMe.txt || die "dodoc failed"

	newinitd "${FILESDIR}"/${PN}.rc6 ${PN}
	newconfd "${FILESDIR}"/${PN}.confd ${PN}
}

pkg_preinst() {
	enewgroup openmcu
	enewuser openmcu -1 -1 /dev/null openmcu
}

pkg_postinst() {
	einfo "Setting permissions..."
	chown -R openmcu:openmcu "${ROOT}"etc/openmcu
	chmod -R u=rwX,g=rX,o=   "${ROOT}"etc/openmcu
	chown -R openmcu:openmcu "${ROOT}"var/{log,run}/openmcu
	chmod -R u=rwX,g=rX,o=   "${ROOT}"var/{log,run}/openmcu

	echo
	elog "This patched version of openmcu stores it's configuration"
	elog "in \"/etc/openmcu/openmcu.ini\""
}
