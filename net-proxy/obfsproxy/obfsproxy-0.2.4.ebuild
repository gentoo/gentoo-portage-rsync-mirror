# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-proxy/obfsproxy/obfsproxy-0.2.4.ebuild,v 1.1 2013/10/06 16:47:24 blueness Exp $

EAPI="5"
PYTHON_COMPAT=( python2_7 )

inherit distutils-r1

DESCRIPTION="An obfuscating proxy using Tor's pluggable transport protocol"
HOMEPAGE="https://www.torproject.org/projects/obfsproxy.html"
SRC_URI="mirror://pypi/o/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

PATCHES=( "${FILESDIR}"/${PN}-remove-argparse.patch )
DOCS=( ChangeLog INSTALL README TODO doc/HOWTO.txt )

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"

RDEPEND=">=dev-python/pyptlib-0.0.5[${PYTHON_USEDEP}]
	>=dev-python/pycrypto-2.6-r2[${PYTHON_USEDEP}]
	dev-python/twisted-core[${PYTHON_USEDEP}]"

pkg_postinst() {
	einfo
	einfo "To run ${PN} with a tor bridge, add the following to your torrc file:"
	einfo
	einfo " SocksPort 0"
	einfo " ORPort 443 # or some other port if you already run a webserver/skype"
	einfo " BridgeRelay 1"
	einfo " ExitPolicy reject *:*"
	einfo " Nickname CHANGEME_1"
	einfo " ContactInfo CHANGEME_2"
	einfo " ServerTransportPlugin obfs2,obfs3 exec /usr/bin/${PN} managed"
	einfo
	einfo "Obviously, change CHANGEME_1 and CHANGEME_2 to appropriate values.  When you"
	einfo "start tor, you should see a message similar to the following in its logs:"
	einfo
	einfo " Oct 05 20:00:41.000 [notice] Registered server transport 'obfs2' at '0.0.0.0:26821"
	einfo " Oct 05 20:00:42.000 [notice] Registered server transport 'obfs3' at '0.0.0.0:40172"
	einfo
	einfo "Note the port numbers, 26821 and 40172 in this case, and report it, along with"
	einfo "your IP address, to your bridge clients.  If you are behind a NAT firewall, you"
	einfo "you need to do port forwarding on those ports."
	einfo
}
