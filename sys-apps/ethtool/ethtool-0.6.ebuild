# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/ethtool/ethtool-0.6.ebuild,v 1.2 2010/10/08 01:52:07 leio Exp $

MY_P="${P/0.}"
DESCRIPTION="Utility for examining and tuning ethernet-based network interfaces"
HOMEPAGE="http://sourceforge.net/projects/gkernel/"
SRC_URI="mirror://sourceforge/gkernel/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 sh sparc x86"
IUSE=""

S=${WORKDIR}/${MY_P}

src_install() {
	emake install DESTDIR="${D}" || die
	dodoc AUTHORS ChangeLog* NEWS README
}
