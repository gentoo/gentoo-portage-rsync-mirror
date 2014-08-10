# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/aewm/aewm-1.2.7.ebuild,v 1.13 2014/08/10 19:56:44 slyfox Exp $

EAPI=1
inherit eutils toolchain-funcs

DESCRIPTION="A minimalistic X11 window manager"
HOMEPAGE="http://www.red-bean.com/~decklin/software/aewm/"
SRC_URI="http://www.red-bean.com/~decklin/software/aewm/${P}.tar.gz"

LICENSE="MIT 9wm"
SLOT="0"
KEYWORDS="amd64 ppc x86 ~x86-fbsd"
IUSE=""

RDEPEND="
	x11-libs/gtk+:2
	x11-libs/libX11
	x11-libs/libXt
	x11-libs/libXaw
	x11-libs/libXft
	x11-libs/libXext"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	x11-proto/xproto
	x11-proto/xextproto"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# Add freetype support.
	sed -i \
		-e '24,26s/^#//' \
		src/Makefile || die "sed failed"

	# Change default font.
	sed -i \
		-e 's/lucidasans-10/-adobe-helvetica-bold-r-normal--*-120-*-*-*-*-*-*/' \
		src/aewmrc.sample || die "sed failed"

	# QA:  Remove stripping
	sed -i \
		-e 's/install -s/install /' \
		{src,clients}/Makefile || die "sed failed"

	epatch "${FILESDIR}"/${P}-ldflags.patch
}

src_compile() {
	tc-export CC
	emake CC="${CC}" CFLAGS="${CFLAGS}" LDFLAGS="${LDFLAGS}" || die
}

src_install() {
	dodir /usr/bin || die
	dodir /usr/share/man/man1 || die

	emake \
		DESTDIR="${D}" \
		MANDIR="${D}/usr/share/man/man1" \
		XROOT="/usr" \
		install || die "emake install failed"

	dodoc DESIGN NEWS README TODO || die
}
