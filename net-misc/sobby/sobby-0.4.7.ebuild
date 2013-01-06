# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/sobby/sobby-0.4.7.ebuild,v 1.5 2012/05/05 03:20:41 jdhore Exp $

EAPI=2

inherit eutils

DESCRIPTION="Standalone Obby server"
HOMEPAGE="http://gobby.0x539.de/"
SRC_URI="http://releases.0x539.de/${PN}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="avahi"

RDEPEND=">=dev-cpp/glibmm-2.6
	>=dev-libs/libsigc++-2.0
	>=dev-libs/gmp-4.1.4
	>=dev-cpp/libxmlpp-2.6
	>=net-libs/net6-1.3.12
	>=net-libs/obby-0.4.6[avahi=]"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

pkg_setup() {
	enewgroup sobby
	enewuser sobby -1 -1 /var/lib/sobby sobby
}

src_configure() {
	econf $(use_enable avahi zeroconf)
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS README || die

	newconfd "${FILESDIR}/${PN}-conf-${PV}" sobby || die
	newinitd "${FILESDIR}/${PN}-init-${PV}" sobby || die

	insinto /etc/sobby
	doins "${FILESDIR}/sobby.xml" || die

	keepdir /var/lib/sobby || die

	fperms -R 0700 /var/lib/sobby || die
	fperms -R 0700 /etc/sobby || die

	fowners sobby:sobby /var/lib/sobby || die
	fowners -R sobby:sobby /etc/sobby || die
}

pkg_postinst() {
	elog "To start sobby, you can use the init script:"
	elog "    /etc/init.d/sobby start"
	elog ""
	elog "Please check the configuration in /etc/sobby/sobby.xml"
	elog "before you start sobby"
}
