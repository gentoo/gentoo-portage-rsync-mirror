# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/unace/unace-2.5.ebuild,v 1.2 2007/02/01 13:58:51 beandog Exp $

DESCRIPTION="ACE unarchiver"
HOMEPAGE="http://www.winace.com/"
SRC_URI="http://www.winace.com/files/linunace${PV//.}.tgz"

LICENSE="freedist"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86"
IUSE=""
RESTRICT="strip"

DEPEND=""

S=${WORKDIR}

src_install() {
	into /opt
	dobin unace || die
}
