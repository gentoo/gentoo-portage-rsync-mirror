# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dns/valtz/valtz-0.7.ebuild,v 1.3 2009/12/03 11:39:32 maekke Exp $

DESCRIPTION="Validation tool for tinydns-data zone files."
SRC_URI="http://x42.com/software/valtz/${PN}.tgz"
HOMEPAGE="http://x42.com/software/valtz/"
IUSE=""

SLOT="0"
LICENSE="BSD"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-lang/perl"

src_install() {
	dobin valtz || die
	dodoc README CHANGES
}
