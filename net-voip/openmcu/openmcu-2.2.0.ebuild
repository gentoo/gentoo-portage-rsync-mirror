# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-voip/openmcu/openmcu-2.2.0.ebuild,v 1.2 2007/01/06 16:36:58 drizzt Exp $

inherit eutils

IUSE=""

DESCRIPTION="H.323 conferencing server"
HOMEPAGE="http://openh323.sourceforge.net/"
SRC_URI="mirror://sourceforge/openh323/${PN}-v${PV//./_}-src-tar.gz"

S=${WORKDIR}/${PN}_v${PV//./_}

SLOT="0"
KEYWORDS="~x86"
LICENSE="MPL-1.0"

DEPEND=">=net-libs/openh323-1.15.2"

src_unpack() {
	tar -xzf ${DISTDIR}/${A} -C ${WORKDIR} || die "Unpacking failed"

	# change locations of various files
	cd ${S}
	epatch ${FILESDIR}/${P}-gentoo.diff
}

src_compile() {

	CFLAGS="${CFLAGS}" \
	PWLIBDIR=/usr/share/pwlib \
	OPENH323DIR=/usr/share/openh323 \
	emake opt || die
}

src_install() {
	dosbin obj_*_*_r/openmcu
	keepdir /var/log/openmcu
	keepdir /var/run/openmcu

	for x in data html; do
		keepdir /usr/share/openmcu/$x
	done

	insinto /usr/share/openmcu/sounds
	doins *.wav

	insinto /etc/openmcu
	doins server.pem
	doins ${FILESDIR}/openmcu.ini

	doman openmcu.1
	dodoc ChangeLog ReadMe.txt mpl-1.0.htm

	newinitd ${FILESDIR}/openmcu.rc6 openmcu
	newconfd ${FILESDIR}/openmcu.confd openmcu
}

pkg_preinst() {
	enewgroup openmcu
	enewuser openmcu -1 -1 /dev/null openmcu
}

pkg_postinst() {
	einfo "Setting permissions..."
	chown -R openmcu:openmcu ${ROOT}etc/openmcu
	chmod -R u=rwX,g=rX,o=	 ${ROOT}etc/openmcu

	chown -R openmcu:openmcu ${ROOT}var/{log,run}/openmcu
	chmod -R u=rwX,g=rX,o=	 ${ROOT}var/{log,run}/openmcu

	echo
	elog "This patched version of openmcu stores it's configuration"
	elog "in \"/etc/openmcu/openmcu.ini\""
}
