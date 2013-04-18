# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/ndppd/ndppd-0.2.3.ebuild,v 1.1 2013/04/17 20:57:30 zx2c4 Exp $

EAPI=5

DESCRIPTION="Proxies NDP messages between interfaces."
HOMEPAGE="http://priv.nu/projects/ndppd/"
SRC_URI="http://priv.nu/projects/ndppd/files/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_install()
{
	emake PREFIX=/usr DESTDIR="${D}" install
	insinto /etc
	newins ndppd.conf-dist ndppd.conf
	newinitd "${FILESDIR}"/ndppd.initd ndppd
}
