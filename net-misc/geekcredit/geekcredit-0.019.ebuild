# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/geekcredit/geekcredit-0.019.ebuild,v 1.7 2014/08/10 20:43:58 slyfox Exp $

inherit python

MY_P=${P/geekcredit/gc}
IUSE=""
DESCRIPTION="Digital complementary currency for internet"
SRC_URI="http://download.gna.org/geekcredit/${MY_P}.tgz"
HOMEPAGE="http://home.gna.org/geekcredit/"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc"
DEPEND="dev-lang/python
		app-crypt/gnupg"

S=${WORKDIR}/${MY_P}

src_compile() {
	einfo "There is nothing to compile."
}

src_install() {
	dobin GCPocket.py
	dodoc *.txt
	cp test.sh "${D}"/usr/share/doc/${P}/
	insinto $(python_get_sitedir)
	doins GeekCredit.py
	insinto /etc
	doins gc.cfg
}

pkg_postinst() {
	elog
	elog "Look at /usr/share/doc/${P}/test.sh for examples of most commands."
	elog
}
