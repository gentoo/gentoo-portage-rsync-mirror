# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/lsdvd/lsdvd-0.16-r2.ebuild,v 1.3 2014/03/18 15:43:54 beandog Exp $

EAPI=2
inherit autotools eutils

DESCRIPTION="Utility for getting info out of DVDs"
HOMEPAGE="http://sourceforge.net/projects/lsdvd/"
SRC_URI="mirror://sourceforge/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~amd64-linux ~ia64-linux ~x86-linux ~ppc-macos"
IUSE=""

RDEPEND="media-libs/libdvdread"
DEPEND="${RDEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/${P}-types.patch \
		"${FILESDIR}"/${P}-usec.patch \
		"${FILESDIR}"/${P}-title.patch
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS NEWS README
}
