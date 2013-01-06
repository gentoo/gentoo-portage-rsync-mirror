# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/openvas-libraries/openvas-libraries-2.0.3.ebuild,v 1.1 2009/07/24 19:29:58 hanno Exp $

DESCRIPTION="A remote security scanner for Linux (openvas-libraries)"
HOMEPAGE="http://www.openvas.org/"
SRC_URI="http://wald.intevation.org/frs/download.php/600/${P}.tar.gz"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND="net-libs/gnutls
	net-libs/libpcap"
RDEPEND="${DEPEND}"

src_install() {
	einstall || die "failed to install"
	find "${D}" -name '*.la' -delete
	dodoc ChangeLog CHANGES TODO || die
}
