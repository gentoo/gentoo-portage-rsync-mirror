# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-backup/mirdir/mirdir-2.1.ebuild,v 1.5 2014/08/10 01:54:01 patrick Exp $

DESCRIPTION=" Mirdir allows to synchronize two directory trees in a fast way"
HOMEPAGE="http://sf.net/projects/mirdir"
SRC_URI="mirror://sourceforge/${PN}/${P}-Unix.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""
DEPEND=""
#RDEPEND=""
S="${WORKDIR}/${P}-UNIX"

src_install() {
	doman mirdir.1
	dobin bin/mirdir
	dodoc AUTHORS
}
