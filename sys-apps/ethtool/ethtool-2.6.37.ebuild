# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/ethtool/ethtool-2.6.37.ebuild,v 1.1 2011/02/20 17:32:27 vapier Exp $

DESCRIPTION="Utility for examining and tuning ethernet-based network interfaces"
HOMEPAGE="http://www.kernel.org/pub/software/network/ethtool/"
SRC_URI="mirror://kernel/software/network/ethtool/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sh ~sparc ~x86"
IUSE=""

src_install() {
	emake install DESTDIR="${D}" || die
	dodoc AUTHORS ChangeLog NEWS README
}
