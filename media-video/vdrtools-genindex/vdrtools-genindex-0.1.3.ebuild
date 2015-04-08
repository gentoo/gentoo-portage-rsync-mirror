# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/vdrtools-genindex/vdrtools-genindex-0.1.3.ebuild,v 1.4 2007/07/12 02:40:43 mr_bones_ Exp $

SCRIPT="genindex"

DESCRIPTION="VDR: genindex Script"
HOMEPAGE="http://www.cadsoft.de/vdr/"
SRC_URI="http://www.muempf.de/down/${SCRIPT}-${PV}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 x86"
IUSE=""

DEPEND=""

S=${WORKDIR}/${SCRIPT}-${PV}

src_install() {
	dodoc README
	dobin genindex
}
