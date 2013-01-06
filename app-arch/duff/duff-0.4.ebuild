# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/duff/duff-0.4.ebuild,v 1.2 2009/10/23 09:19:11 robbat2 Exp $

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
