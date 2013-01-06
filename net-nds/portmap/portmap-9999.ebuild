# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-nds/portmap/portmap-9999.ebuild,v 1.5 2012/12/09 12:34:07 ulm Exp $

EGIT_REPO_URI="git://neil.brown.name/portmap"
inherit toolchain-funcs user git-2

DESCRIPTION="Netkit - portmapper"
HOMEPAGE="ftp://ftp.porcupine.org/pub/security/index.html"
SRC_URI=""

LICENSE="BSD GPL-2" # GPL-2 only for init script
SLOT="0"
KEYWORDS=""
IUSE="selinux tcpd"

DEPEND="selinux? ( sec-policy/selinux-portmap )
	tcpd? ( >=sys-apps/tcp-wrappers-7.6-r7 )"

pkg_setup() {
	enewgroup rpc 111
	enewuser rpc 111 -1 /dev/null rpc
}

src_compile() {
	tc-export CC
	emake NO_TCP_WRAPPER="$(use tcpd || echo NO)" || die
}

src_install() {
	into /
	dosbin portmap || die "portmap"
	into /usr
	dosbin pmap_dump pmap_set || die "pmap"

	doman *.8
	dodoc BLURBv5 CHANGES README*

	newinitd "${FILESDIR}"/portmap.rc6 portmap
	newconfd "${FILESDIR}"/portmap.confd portmap
}
