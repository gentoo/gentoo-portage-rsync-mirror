# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/vpnc/vpnc-0.5.3_p527.ebuild,v 1.6 2013/04/05 21:48:32 ago Exp $

EAPI=5

inherit eutils linux-info toolchain-funcs

DESCRIPTION="Free client for Cisco VPN routing software"
HOMEPAGE="http://www.unix-ag.uni-kl.de/~massar/vpnc/"
SRC_URI="http://dev.gentoo.org/~jlec/distfiles/${PF}.tar.xz"

LICENSE="GPL-2 BSD"
SLOT="0"
KEYWORDS="amd64 arm ppc ppc64 ~sparc x86"
IUSE="resolvconf +gnutls bindist"

REQUIRED_USE="bindist? ( gnutls )"

DEPEND="
	dev-lang/perl
	dev-libs/libgcrypt
	>=sys-apps/iproute2-2.6.19.20061214[-minimal]
	gnutls? ( net-libs/gnutls )
	!gnutls? ( dev-libs/openssl )"
RDEPEND="${DEPEND}
	resolvconf? ( net-dns/openresolv )"

CONFIG_CHECK="~TUN"

src_prepare() {
	if ! use gnutls && ! use bindist; then
		sed -i -e '/^#OPENSSL_GPL_VIOLATION/s:#::g' "${S}"/Makefile	|| die
		ewarn "Building SSL support with OpenSSL instead of GnuTLS.  This means that"
		ewarn "you are not allowed to re-distibute the binaries due to conflicts between BSD license and GPL,"
		ewarn "see the vpnc Makefile and http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=440318"
	else
		elog "Will build with GnuTLS (default) instead of OpenSSL so you may even redistribute binaries."
		elog "See the Makefile itself and http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=440318"
	fi

	epatch "${FILESDIR}"/${PN}-0.5.3_p514-as-needed.patch

	sed -e 's:test/cert0.pem::g' -i Makefile || die

	tc-export CC
}

src_install() {
	emake PREFIX="/usr" DESTDIR="${D}" install
	dodoc README TODO VERSION
	keepdir /etc/vpnc/scripts.d
	newinitd "${FILESDIR}/vpnc-3.init" vpnc
	newconfd "${FILESDIR}/vpnc.confd" vpnc
	sed -e "s:/usr/local:/usr:" -i "${D}"/etc/vpnc/vpnc-script || die
	# COPYING file resides here, should not be installed
	rm -rf "${D}"/usr/share/doc/vpnc/ || die
}

pkg_postinst() {
	elog "You can generate a configuration file from the original Cisco profiles of your"
	elog "connection by using /usr/bin/pcf2vpnc to convert the .pcf file"
	elog "A guide is available in http://www.gentoo.org/doc/en/vpnc-howto.xml"
}
