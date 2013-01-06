# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/pngnq/pngnq-1.0.ebuild,v 1.6 2011/08/08 16:37:28 ssuominen Exp $

EAPI=4
inherit autotools eutils

DESCRIPTION="Pngnq is a tool for quantizing PNG images in RGBA format."
HOMEPAGE="http://pngnq.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="media-libs/libpng"
DEPEND="${RDEPEND}"

DOCS=( NEWS README )

src_prepare() {
	epatch \
		"${FILESDIR}"/${P}-as-needed.patch \
		"${FILESDIR}"/${P}-libpng1{4,5}.patch

	eautoreconf
}
