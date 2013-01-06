# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/xsupplicant/xsupplicant-2.2.0.ebuild,v 1.2 2010/06/23 21:38:41 hwoarang Exp $

EAPI=3

inherit autotools

MY_P="XSupplicant-${PV}-src"
DESCRIPTION="Open1X xsupplicant is an open source implementation of the IEEE 802.1X
protocol."
HOMEPAGE="http://open1x.sourceforge.net/"
SRC_URI="mirror://sourceforge/open1x/${MY_P}.tar.gz"

LICENSE="|| ( GPL-2 BSD )"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-libs/libxml2
	dev-libs/openssl
	net-wireless/wireless-tools
	sys-libs/zlib"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}/xsupplicant"

src_prepare() {
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die "Install failed"
	dodoc README TODO || die

	newconfd "${FILESDIR}"/${PN}-1.2.2-conf.d ${PN}
	newinitd "${FILESDIR}"/${PN}-1.2.2-init.d ${PN}

	docinto examples
	dodoc etc/md5-example.conf etc/peap-example.conf etc/tls-example.conf \
		etc/ttls-example.conf  etc/wpa-psk-example.conf
}

pkg_postinst() {
	einfo
	elog "To use ${P} you must create the configuration file"
	elog "    /etc/xsupplicant.conf"
	einfo
	elog "Example configuration files have been installed at"
	elog "    /usr/share/doc/${P}/examples"
	einfo
}
