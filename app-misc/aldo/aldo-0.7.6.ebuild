# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/aldo/aldo-0.7.6.ebuild,v 1.2 2010/08/10 11:34:59 xarthisius Exp $

EAPI=2

DESCRIPTION="a morse tutor"
HOMEPAGE="http://www.nongnu.org/aldo"
SRC_URI="http://savannah.nongnu.org/download/aldo/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND=">=media-libs/libao-0.8.5"
DEPEND="${RDEPEND}"

src_configure() {
	econf --disable-dependency-tracking
}

src_compile() {
	emake LDFLAGS="${LDFLAGS}" || die
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS README THANKS || die
}
