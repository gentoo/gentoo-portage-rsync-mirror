# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-geosciences/josm-plugins/josm-plugins-20100531.ebuild,v 1.1 2010/05/31 11:19:45 hanno Exp $

EAPI="3"

DESCRIPTION="Set of plugins for josm"
HOMEPAGE="http://josm.openstreetmap.de/"
SRC_URI="mirror://gentoo/${P}.tar.xz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
DEPEND=">=sci-geosciences/josm-3.208"
RDEPEND="${DEPEND}"
IUSE=""

src_compile() {
	einfo Nothing to compile
}

src_install() {
	insinto /usr/lib/josm/plugins
	doins *.jar
}
