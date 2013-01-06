# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/dnstracer/dnstracer-1.9.ebuild,v 1.7 2012/12/08 11:55:45 pinkbyte Exp $

inherit flag-o-matic

DESCRIPTION="Determines where a given nameserver gets its information from"
HOMEPAGE="http://www.mavetju.org/unix/general.php"
SRC_URI="http://www.mavetju.org/download/${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="amd64 arm hppa ia64 ~ppc ppc64 s390 sparc x86"
IUSE="ipv6"

DEPEND=""
RDEPEND=""

src_compile() {
	econf $(use_enable ipv6) || die
	emake || die
}

src_install() {
	make DESTDIR="${D}" install || die
	dodoc README CHANGES
}
