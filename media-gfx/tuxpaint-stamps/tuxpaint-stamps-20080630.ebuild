# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/tuxpaint-stamps/tuxpaint-stamps-20080630.ebuild,v 1.4 2009/03/19 19:05:21 maekke Exp $

MY_P="${PN}-${PV:0:4}.${PV:4:2}.${PV:6:2}"
DESCRIPTION="Set of 'Rubber Stamp' images which can be used within Tux Paint"
HOMEPAGE="http://www.tuxpaint.org/"

DEPEND="media-gfx/tuxpaint"
RDEPEND="${DEPEND}"

IUSE=""
SRC_URI="mirror://sourceforge/tuxpaint/${MY_P}.tar.gz"
S="${WORKDIR}/${MY_P}"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="amd64 ppc x86"

src_install () {
	make PREFIX="${D}/usr" install-all || die "Installation failed"

	rm -f docs/COPYING.txt
	dodoc docs/*.txt
}
