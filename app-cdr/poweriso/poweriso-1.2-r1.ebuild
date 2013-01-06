# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/poweriso/poweriso-1.2-r1.ebuild,v 1.3 2008/10/24 22:46:07 maekke Exp $

DESCRIPTION="Utility to extract, list and convert PowerISO DAA image files"
HOMEPAGE="http://www.poweriso.com"
SRC_URI="http://www.${PN}.com/${P}.tar.gz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

S=${WORKDIR}

RESTRICT="strip"

src_install() {
	into /opt
	dobin ${PN}
}
