# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-firewall/dshieldpy/dshieldpy-3.2.ebuild,v 1.8 2011/04/05 05:46:48 ulm Exp $

DESCRIPTION="Python script to submit firewall logs to dshield.org"
HOMEPAGE="http://dshieldpy.sourceforge.net/"
SRC_URI="mirror://sourceforge/dshieldpy/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE=""
DEPEND="dev-lang/python"
RDEPEND=""
S=${WORKDIR}/DShield.py

src_install() {
	dodoc CHANGELOG COPYING README*
	dobin dshield.py

	insinto /etc
	doins dshieldpy.conf
}
