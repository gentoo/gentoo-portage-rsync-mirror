# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/bbe/bbe-0.2.2.ebuild,v 1.4 2013/06/08 09:27:37 pinkbyte Exp $

EAPI=5

inherit autotools

DESCRIPTION="Sed-like editor for binary files."
HOMEPAGE="http://sourceforge.net/projects/bbe-/"
SRC_URI="mirror://sourceforge/${PN}-/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE=""

src_prepare() {
	sed -i -e '/^htmldir/d' doc/Makefile.am || die
	eautoreconf
}

src_configure() {
	econf --htmldir=/usr/share/doc/${PF}/html
}
