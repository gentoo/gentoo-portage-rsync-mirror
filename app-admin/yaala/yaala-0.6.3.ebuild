# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/yaala/yaala-0.6.3.ebuild,v 1.11 2009/10/12 00:03:59 halcy0n Exp $

DESCRIPTION="Yet Another Log Analyzer"
HOMEPAGE="http://yaala.org/"
SRC_URI="http://yaala.org/files/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc"
IUSE=""

DEPEND=""

src_install() {
	dodir /usr/share/yaala
	cp -pRx * "${D}"/usr/share/yaala/
}
