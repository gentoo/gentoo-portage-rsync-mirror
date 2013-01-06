# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/duff/duff-0.5.ebuild,v 1.1 2011/11/07 08:27:51 robbat2 Exp $

DESCRIPTION="Command-line utility for quickly finding duplicates in a given set of files"
HOMEPAGE="http://duff.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
LICENSE="ZLIB"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""
DEPEND=""
RDEPEND=""

src_install() {
	emake DESTDIR="${D}" install || die "Failed emake install"
	dodoc AUTHORS ChangeLog HACKING NEWS README* TODO
}
