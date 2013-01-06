# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/openvas-plugins/openvas-plugins-1.0.7.ebuild,v 1.2 2009/11/07 20:22:23 volkmar Exp $

DESCRIPTION="A remote security scanner for Linux (openvas-plugins)"
HOMEPAGE="http://www.openvas.org/"
SRC_URI="http://wald.intevation.org/frs/download.php/588/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""
DEPEND="net-analyzer/openvas-server"
RDEPEND="${DEPEND}"

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc docs/*.txt || die "dodoc failed"
}
