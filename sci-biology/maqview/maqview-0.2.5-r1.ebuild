# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/maqview/maqview-0.2.5-r1.ebuild,v 1.3 2011/05/11 19:19:47 angelos Exp $

EAPI=4

inherit autotools eutils

DESCRIPTION="GUI for sci-biology/maq, a short read mapping assembler"
HOMEPAGE="http://maq.sourceforge.net/"
SRC_URI="mirror://sourceforge/maq/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
IUSE=""
KEYWORDS="amd64 x86"

DEPEND="
	media-libs/freeglut
	sys-libs/zlib"
RDEPEND="${DEPEND}
	sci-biology/maq"

S="${WORKDIR}/${PN}"

src_prepare() {
	epatch \
		"${FILESDIR}"/${PV}-ldflags.patch \
		"${FILESDIR}"/${PV}-zlib.patch
	eautoreconf
}
