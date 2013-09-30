# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/dzen/dzen-0.9.5-r1.ebuild,v 1.3 2013/09/30 17:18:04 ago Exp $

EAPI=5
inherit eutils toolchain-funcs vcs-snapshot

COMMITID="f7907da3a42a6d59e27ede88f5f01e4e41c4c9e0"

DESCRIPTION="a general purpose messaging, notification and menuing program for X11"
HOMEPAGE="https://github.com/robm/dzen"
SRC_URI="https://github.com/robm/${PN}/tarball/${COMMITID} -> ${P}.tar.gz"

LICENSE="MIT"
KEYWORDS="amd64 x86"
IUSE="minimal xft xinerama xpm"
SLOT="2"

RDEPEND="
	x11-libs/libX11
	xft? ( x11-libs/libXft )
	xinerama? ( x11-libs/libXinerama )
	xpm? ( x11-libs/libXpm )
"
DEPEND="
	${RDEPEND}
	virtual/pkgconfig
	x11-proto/xproto
	xinerama? ( x11-proto/xineramaproto )
"

DOCS=( README )

src_prepare() {
	epatch "${FILESDIR}"/${P}-off-by-one.patch

	sed -i \
		-e "s:-L/usr/lib::g" \
		-e '/^CC.*/d' \
		-e 's:-Os::g' \
		-e 's:/usr/local:/usr:g' \
		-e 's:CFLAGS =:CFLAGS +=:g' \
		-e 's:^LDFLAGS =:LDFLAGS +=:' \
		config.mk gadgets/config.mk || die

	sed -i \
		-e '/strip/d' \
		-e 's:^	@:	:g' \
		Makefile gadgets/Makefile \
		|| die
}

src_configure() {
	if use xinerama ; then
		sed -e "/^LIBS/s/$/\ -lXinerama/" \
			-e "/^CFLAGS/s/$/\ -DDZEN_XINERAMA/" \
			-i config.mk || die
	fi
	if use xpm ; then
		sed -e "/^LIBS/s/$/\ -lXpm/" \
			-e "/^CFLAGS/s/$/\ -DDZEN_XPM/" \
			-i config.mk || die
	fi
	if use xft ; then
		sed -e "/^LIBS/s/$/\ \`pkg-config --libs xft\`/" \
			-e "/^CFLAGS/s/$/\ -DDZEN_XFT \`pkg-config --cflags xft\`/" \
			-i config.mk || die
	fi

	tc-export CC
}

src_compile() {
	default
	use minimal || emake -C gadgets
}

src_install() {
	default

	if ! use minimal ; then
		emake -C gadgets DESTDIR="${D}" install
		dobin gadgets/*.sh
		dodoc gadgets/README*
	fi
}
