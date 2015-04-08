# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/mpg321/mpg321-0.3.1.ebuild,v 1.8 2012/12/30 14:16:40 ago Exp $

EAPI=4
inherit autotools eutils

DESCRIPTION="A realtime MPEG 1.0/2.0/2.5 audio player for layers 1, 2 and 3"
HOMEPAGE="http://mpg321.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ~arm hppa ~mips ppc ppc64 sparc x86 ~x86-fbsd ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE="ipv6"

RDEPEND=">=media-libs/libao-1
	media-libs/libid3tag
	media-libs/libmad
	sys-libs/zlib"
DEPEND="${RDEPEND}"

S=${WORKDIR}/${P}-orig

DOCS="AUTHORS BUGS HACKING README* THANKS TODO" # NEWS and ChangeLog are dead

src_prepare() {
	epatch "${FILESDIR}"/${PN}-0.2.12-check-for-lround.patch
	eautoreconf
}

src_configure() {
	econf \
		--disable-mpg123-symlink \
		$(use_enable ipv6)
}
