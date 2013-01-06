# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/openvas-libnasl/openvas-libnasl-2.0.2.ebuild,v 1.1 2009/09/07 16:22:37 hanno Exp $

DESCRIPTION="A remote security scanner for Linux (openvas-libnasl)"
HOMEPAGE="http://www.openvas.org/"
SRC_URI="http://wald.intevation.org/frs/download.php/619/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND=">=net-analyzer/openvas-libraries-2.0.4
	app-crypt/gpgme"
RDEPEND="${DEPEND}"

src_install() {
	einstall || die "einstall failed"
	find "${D}" -name '*.la' -delete
	dodoc ChangeLog || die "dodoc failed"
}
