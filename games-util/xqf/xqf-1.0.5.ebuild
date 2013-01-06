# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-util/xqf/xqf-1.0.5.ebuild,v 1.11 2012/05/03 03:41:15 jdhore Exp $

EAPI=2
inherit base eutils

DESCRIPTION="A server browser for many FPS games (frontend for qstat)"
HOMEPAGE="http://www.linuxgames.com/xqf/"
SRC_URI="mirror://sourceforge/xqf/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 hppa ppc x86"
IUSE="bzip2 geoip nls"

RDEPEND="x11-libs/gtk+:2
	>=games-util/qstat-2.11
	nls? ( virtual/libintl )
	geoip? ( dev-libs/geoip )
	bzip2? ( app-arch/bzip2 )"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	nls? ( sys-devel/gettext )"

# bug #288853
PATCHES=( "${FILESDIR}"/${P}-cpu-overrun.patch
	"${FILESDIR}"/${P}-underlink.patch
	"${FILESDIR}"/${P}-zlib-1.2.5.1-compile-fix.patch )

src_configure() {
	econf \
		$(use_enable nls) \
		$(use_enable geoip) \
		$(use_enable bzip2) \
		--enable-gtk2
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS BUGS ChangeLog NEWS README TODO
}
