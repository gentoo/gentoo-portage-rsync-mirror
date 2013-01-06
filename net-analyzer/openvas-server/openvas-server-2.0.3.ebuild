# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/openvas-server/openvas-server-2.0.3.ebuild,v 1.2 2009/11/07 20:18:04 volkmar Exp $

DESCRIPTION="A remote security scanner for Linux (openvas-server)"
HOMEPAGE="http://www.openvas.org/"
SRC_URI="http://wald.intevation.org/frs/download.php/624/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="tcpd gtk debug prelude"

DEPEND=">=net-analyzer/openvas-libnasl-2.0.2
	tcpd? ( sys-apps/tcp-wrappers )
	gtk? ( =x11-libs/gtk+-2* )
	prelude? ( dev-libs/libprelude )"
RDEPEND="${DEPEND}"

src_compile() {
	econf \
		$(use_enable tcpd tcpwrappers) \
		$(use_enable debug) \
		$(use_enable gtk) \
		|| die "configure failed"
	emake || die "emake failed"
}

src_install() {
	einstall || die "einstall failed"

	dodoc TODO CHANGES || die
	dodoc doc/*.txt || die

	doinitd "${FILESDIR}"/openvasd || die "doinitd failed"
	keepdir /var/lib/openvas/logs
	keepdir /var/lib/openvas/users
}
