# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-firewall/lutelwall/lutelwall-0.99.ebuild,v 1.5 2007/05/06 09:57:47 genone Exp $

DESCRIPTION="High-level tool for firewall configuration"
HOMEPAGE="http://firewall.lutel.pl"
SRC_URI="http://firewall.lutel.pl/download/${PV}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha ~amd64 ~ppc ~sparc x86"
IUSE=""

DEPEND=">=net-firewall/iptables-1.2.6
	sys-apps/iproute2
	>=sys-apps/gawk-3.1"

src_install() {
	insinto /etc ; doins lutelwall.conf
	dosbin lutelwall
	doinitd "${FILESDIR}"/lutelwall
	dodoc FEATURES ChangeLog
}

pkg_postinst() {
	elog "Basic configuration file is /etc/lutelwall.conf"
	elog "Adjust it to your needs before using"
}
