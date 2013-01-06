# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/openvas-libnasl/openvas-libnasl-2.0.1.ebuild,v 1.2 2009/03/19 13:36:17 ranger Exp $

DESCRIPTION="A remote security scanner for Linux (openvas-libnasl)"
HOMEPAGE="http://www.openvas.org/"
SRC_URI="http://wald.intevation.org/frs/download.php/561/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND=">=net-analyzer/openvas-libraries-2.0.0
	app-crypt/gpgme"
RDEPEND="${DEPEND}"

src_install() {
	einstall || die "einstall failed"
	find "${D}" -name '*.la' -delete
	dodoc ChangeLog || die "dodoc failed"
}
