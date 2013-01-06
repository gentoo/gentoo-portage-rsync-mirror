# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/tcptrack/tcptrack-1.4.2.ebuild,v 1.2 2011/08/06 03:30:30 phajdan.jr Exp $

EAPI="4"

inherit autotools

DESCRIPTION="Passive per-connection tcp bandwidth monitor"
HOMEPAGE="http://www.rhythm.cx/~steve/devel/tcptrack/"
SRC_URI="http://www.rhythm.cx/~steve/devel/tcptrack/release/${PV}/source/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE=""

DEPEND="net-libs/libpcap
	sys-libs/ncurses"
RDEPEND="${DEPEND}"

src_prepare() {
	sed -i src/Makefile.am -e 's| -Werror||g' || die
	eautomake
}
