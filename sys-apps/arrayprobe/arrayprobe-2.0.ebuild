# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/arrayprobe/arrayprobe-2.0.ebuild,v 1.4 2010/09/17 09:25:36 robbat2 Exp $

DESCRIPTION="CLI utility that reports the status of a HP (Compaq) array controller (both IDA & CCISS supported)."
HOMEPAGE="http://www.strocamp.net/opensource/arrayprobe.php"
SRC_URI="http://www.strocamp.net/opensource/compaq/downloads/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE=""
DEPEND=""

src_install() {
	make DESTDIR="${D}" install || die
}
