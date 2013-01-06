# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-laptop/radeontool/radeontool-1.6.3.ebuild,v 1.5 2012/12/03 20:41:51 ago Exp $

EAPI=2
inherit eutils toolchain-funcs

DESCRIPTION="Manage the backlight, external video output and registers of ATI Radeon graphics cards"

HOMEPAGE="http://cgit.freedesktop.org/~airlied/radeontool/"
SRC_URI="http://people.freedesktop.org/~airlied/${PN}/${P}.tar.bz2"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"

IUSE=""

RDEPEND=">=x11-libs/libpciaccess-0.12.0"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_install() {
	emake install DESTDIR="${D}"
}
