# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/cdcd/cdcd-0.6.6-r2.ebuild,v 1.7 2009/06/19 21:42:15 ranger Exp $

EAPI=2
inherit autotools eutils

DESCRIPTION="a simple yet powerful command line cd player"
HOMEPAGE="http://libcdaudio.sourceforge.net"
SRC_URI="mirror://sourceforge/libcdaudio/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~hppa ~ppc ppc64 sparc x86 ~x86-fbsd"
IUSE=""

RDEPEND="sys-libs/ncurses
	>=sys-libs/readline-4.2
	>=media-libs/libcdaudio-0.99.4"
DEPEND="${RDEPEND}"

src_prepare() {
	epatch "${FILESDIR}/${P}-fbsd.patch"
	eautoconf
}

src_install () {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog NEWS README
}
