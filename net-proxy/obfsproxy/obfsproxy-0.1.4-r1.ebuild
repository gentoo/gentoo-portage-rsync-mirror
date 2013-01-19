# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-proxy/obfsproxy/obfsproxy-0.1.4-r1.ebuild,v 1.1 2013/01/19 16:00:48 blueness Exp $

EAPI="4"

inherit toolchain-funcs

DESCRIPTION="A tor-compliant pluggable transports proxy to obfuscate tor traffic"
HOMEPAGE="https://www.torproject.org/projects/obfsproxy.html"
SRC_URI="https://archive.torproject.org/tor-package-archive/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~mips ~ppc ~ppc64 ~x86"
IUSE="daemon"

DEPEND="dev-libs/openssl
	>=dev-libs/libevent-2
	sys-libs/zlib"
RDEPEND="${DEPEND}"

src_prepare() {
	sed -i -e "s:^AR = ar:AR = $(tc-getAR):" Makefile.in || die
}

src_install() {
	if use daemon; then
		newconfd "${FILESDIR}"/obfsproxy.confd obfsproxy
		newinitd "${FILESDIR}"/obfsproxy.initd obfsproxy
	fi

	emake DESTDIR="${D}" install
	dodoc README ChangeLog
	dodoc -r doc/*
}

pkg_postinst() {
	einfo
	einfo "To run ${PN} with a tor bridge, add the following to your torrc file:"
	einfo
	einfo " ORPort 5001"
	einfo " BridgeRelay 1"
	einfo " ExitPolicy reject *:*"
	einfo " ServerTransportPlugin obfs2 exec /usr/bin/${PN} --managed"
	einfo
	einfo "Change your ORPort to whatever value you use.  When you start tor,"
	einfo "you should see a message similar to the following in its logs:"
	einfo
	einfo " Registered server transport 'obfs2' at '0.0.0.0:33578'"
	einfo
	einfo "Note the port number, 33578 in this case, and report it, along with"
	einfo "your IP address, to your bridge clients."
	einfo
	einfo
	einfo "To run ${PN} with a tor client, add the following to your torrc file:"
	einfo
	einfo " SocksPort 5000"
	einfo " UseBridges 1"
	einfo " Bridge obfs2 <IP>:<port>"
	einfo " ClientTransportPlugin obfs2 exec /usr/bin/${PN} --managed"
	einfo
	einfo "Change your SocksPort to whatever value you use.  Also, replace the"
	einfo "<IP>:<port> pair with the values you received from the tor obfs bridge."
	einfo
}
