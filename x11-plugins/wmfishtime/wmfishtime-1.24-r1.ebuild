# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmfishtime/wmfishtime-1.24-r1.ebuild,v 1.8 2012/05/05 05:12:00 jdhore Exp $

EAPI="1"

inherit eutils toolchain-funcs

DESCRIPTION="A fun clock applet for your desktop featuring swimming fish"
HOMEPAGE="http://www.ne.jp/asahi/linux/timecop"
SRC_URI="http://www.ne.jp/asahi/linux/timecop/software/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 sparc x86"
IUSE=""

RDEPEND="x11-libs/gtk+:2
	x11-libs/libX11"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-gtk.patch
}

src_compile() {
	emake CC="$(tc-getCC)" || die "emake failed."
}

src_install() {
	dobin ${PN}
	doman ${PN}.1
	dodoc ALL_I_GET_IS_A_GRAY_BOX AUTHORS ChangeLog CODING README
}
