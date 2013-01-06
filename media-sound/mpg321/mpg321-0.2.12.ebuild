# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/mpg321/mpg321-0.2.12.ebuild,v 1.9 2010/10/15 13:34:51 ranger Exp $

EAPI=2

MY_P=${P}-1

DESCRIPTION="a realtime MPEG 1.0/2.0/2.5 audio player for layers 1, 2 and 3"
HOMEPAGE="http://mpg321.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ~arm hppa ppc ppc64 sparc x86 ~x86-fbsd ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE="alsa ipv6"

RDEPEND="sys-libs/zlib
	media-libs/libmad
	media-libs/libid3tag
	media-libs/libao[alsa?]"
DEPEND="${RDEPEND}"

S=${WORKDIR}/${MY_P}

src_configure() {
	econf \
		--disable-dependency-tracking \
		--disable-mpg123-symlink \
		$(use_enable ipv6)
}

src_install() {
	emake DESTDIR="${D}" install || die
	newdoc debian/changelog ChangeLog.debian
	dodoc AUTHORS BUGS HACKING NEWS README{,.remote} THANKS TODO
}
