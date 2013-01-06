# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmfishtime/wmfishtime-1.24-r2.ebuild,v 1.6 2012/05/05 05:12:00 jdhore Exp $

EAPI=4
inherit eutils toolchain-funcs

DESCRIPTION="A fun clock applet for your desktop featuring swimming fish"
HOMEPAGE="http://www.ne.jp/asahi/linux/timecop"
SRC_URI="http://www.ne.jp/asahi/linux/timecop/software/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc ~ppc64 ~sparc x86"
IUSE=""

RDEPEND="x11-libs/gtk+:2
	x11-libs/libX11"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_prepare() {
	epatch "${FILESDIR}"/${P}-gtk.patch
	epatch "${FILESDIR}"/${P}-no_display.patch
	sed -i -e "s/\$(CC)/& \$(LDFLAGS)/" Makefile || die #331891
}

src_compile() {
	emake CC="$(tc-getCC)"
}

src_install() {
	dobin ${PN}
	doman ${PN}.1
	dodoc ALL_I_GET_IS_A_GRAY_BOX AUTHORS ChangeLog CODING README
}
