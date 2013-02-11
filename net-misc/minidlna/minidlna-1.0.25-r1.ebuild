# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/minidlna/minidlna-1.0.25-r1.ebuild,v 1.7 2013/02/11 21:30:08 pinkbyte Exp $

EAPI=4

inherit eutils toolchain-funcs user

DESCRIPTION="DLNA/UPnP-AV compliant media server"
HOMEPAGE="http://minidlna.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${PN}_${PV}_src.tar.gz"

LICENSE="BSD GPL-2"
SLOT="0"
KEYWORDS="amd64 ~arm ~x86"
IUSE=""

RDEPEND="dev-db/sqlite
	media-libs/flac
	media-libs/libexif
	media-libs/libid3tag
	media-libs/libogg
	media-libs/libvorbis
	virtual/ffmpeg
	virtual/jpeg"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

pkg_setup() {
	local my_is_new="yes"
	[ -d "${EPREFIX}"/var/lib/${PN} ] && my_is_new="no"
	enewgroup ${PN}
	enewuser ${PN} -1 -1 /var/lib/${PN} ${PN}
	if [ -d "${EPREFIX}"/var/lib/${PN} ] && [ "${my_is_new}" == "yes" ] ; then
		# created by above enewuser command w/ wrong group and permissions
		chown ${PN}:${PN} "${EPREFIX}"/var/lib/${PN} || die
		chmod 0750 "${EPREFIX}"/var/lib/${PN} || die
		# if user already exists, but /var/lib/minidlna is missing
		# rely on ${D}/var/lib/minidlna created in src_install
	fi
}

src_prepare() {
	epatch "${FILESDIR}"/${PN}-1.0.18-Makefile.patch
	epatch "${FILESDIR}"/${PN}-1.0.25-ffmpeg.patch

	sed -e "/^DB_PATH=/s:\".*\":\"${EPREFIX}/var/lib/${PN}\":" \
		-e "/^LOG_PATH=/s:\".*\":\"${EPREFIX}/var/log\":" \
		-i ./genconfig.sh || die
}

src_configure() {
	./genconfig.sh || die
}

src_compile() {
	emake CC="$(tc-getCC)"
}

src_install() {
	emake DESTDIR="${D}" install install-conf

	newconfd "${FILESDIR}"/${P}.confd ${PN}
	newinitd "${FILESDIR}"/${P}.initd ${PN}

	dodir /var/lib/${PN} /var/log
	echo -n > "${ED}"/var/log/${PN}.log
	fowners ${PN}:${PN} /var/lib/${PN} /var/log/${PN}.log
	fperms 0750 /var/lib/${PN}
	fperms 0640 /var/log/${PN}.log

	dodoc NEWS README TODO
}

pkg_postinst() {
	elog "minidlna now runs as minidlna:minidlna (bug 426726),"
	elog "logfile is moved to /var/log/minidlna.log,"
	elog "cache is moved to /var/lib/minidlna."
	elog "Please edit /etc/conf.d/${PN} and file ownerships to suit your needs."
}
