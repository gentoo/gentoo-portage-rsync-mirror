# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/vpnc/vpnc-0.5.3_p457-r1.ebuild,v 1.2 2012/04/01 05:41:52 jlec Exp $

EAPI=4

DESCRIPTION="Free client for Cisco VPN routing software"
HOMEPAGE="http://www.unix-ag.uni-kl.de/~massar/vpnc/"
# Modified vpnc-script taken from
# http://git.infradead.org/users/dwmw2/vpnc-scripts.git, supports Solaris and IP v6, as reported in bug
# Additionally added patches to fix some dead lock problems taken from
# http://lists.unix-ag.uni-kl.de/pipermail/vpnc-devel/2010-March/003445.html
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2 BSD"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ppc ~ppc64 ~sparc ~x86"
IUSE="resolvconf +gnutls bindist"

DEPEND=">=dev-libs/libgcrypt-1.1.91
	>=sys-apps/iproute2-2.6.19.20061214
	bindist? ( net-libs/gnutls )
	!bindist? (
		gnutls? ( net-libs/gnutls )
		!gnutls? ( dev-libs/openssl )
	)"
RDEPEND="${DEPEND}
	resolvconf? ( net-dns/openresolv )"

src_prepare() {
	if ! use gnutls && ! use bindist; then
		sed -i -e 's/#OPENSSL_GPL_VIOLATION=yes/OPENSSL_GPL_VIOLATION=yes/' "${S}"/Makefile \
			|| die
		ewarn "Building SSL support with OpenSSL instead of GnuTLS.  This means that"
		ewarn "you are not allowed to re-distibute the binaries due to conflicts between BSD license and GPL,"
		ewarn "see the vpnc Makefile and http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=440318"
	else
		elog "Will build with GnuTLS (default) instead of OpenSSL so you may even redistribute binaries."
		elog "See the Makefile itself and http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=440318"
	fi
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
	echo
	elog "Don't forget to turn on TUN support in the kernel."
}
