# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/thrulay/thrulay-0.6.ebuild,v 1.5 2014/08/10 21:00:52 slyfox Exp $

inherit toolchain-funcs

DESCRIPTION="Measure the capacity of a network by sending a bulk TCP stream over it"
HOMEPAGE="http://www.internet2.edu/~shalunov/thrulay/"
SRC_URI="http://www.internet2.edu/~shalunov/thrulay/${P}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="x86"
IUSE=""
DEPEND=""

src_compile() {
	emake CC="$(tc-getCC)" OPT="${CFLAGS}" || die "emake failed"
}

src_install() {
	dobin thrulay || die "dobin failed"
	dosbin thrulayd || die "dosbin failed"
	dodoc LICENSE README TODO thrulay-protocol.txt || die "dodoc failed"
	newinitd "${FILESDIR}"/thrulayd-init.d thrulayd || die "newinitd failed"
	newconfd "${FILESDIR}"/thrulayd-conf.d thrulayd || die "newconfd failed"
}
