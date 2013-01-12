# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/saku/saku-3.11.0-r1.ebuild,v 1.1 2013/01/12 04:56:54 naota Exp $

EAPI=3

PYTHON_DEPEND="2:2.5"

inherit distutils eutils

DESCRIPTION="a clone of P2P anonymous BBS shinGETsu"
HOMEPAGE="http://shingetsu.info/"
SRC_URI="mirror://sourceforge/shingetsu/${P}.tar.gz"

LICENSE="BSD-2 GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/cheetah"
RDEPEND="${DEPEND}"

pkg_setup() {
	enewgroup saku
	enewuser saku -1 -1 /var/run/saku saku
}

src_prepare() {
	sed -i -e "/^prefix/s:/usr:${EPREFIX}/usr:" file/saku.ini || die
	sed -i -e "s:root/share/doc/saku/:root/share/doc/${PF}/:" setup.py || die
}

src_install() {
	distutils_src_install

	dodir /etc/saku
	insinto /etc/saku
	doins "${FILESDIR}"/saku.ini

	doinitd "${FILESDIR}"/saku

	diropts -o saku -g saku
	dodir /var/log/saku
	dodir /var/spool/saku
}
