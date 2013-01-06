# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/i3/i3-4.4.ebuild,v 1.2 2012/12/16 17:35:59 xarthisius Exp $

EAPI=4

inherit toolchain-funcs

DESCRIPTION="An improved dynamic tiling window manager"
HOMEPAGE="http://i3wm.org/"
SRC_URI="http://i3wm.org/downloads/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+pango"

CDEPEND="dev-libs/libev
	dev-libs/libpcre
	dev-libs/yajl
	x11-libs/libxcb
	x11-libs/libXcursor
	x11-libs/libX11
	x11-libs/startup-notification
	x11-libs/xcb-util
	pango? (
		>=x11-libs/pango-1.30.0[X]
		>=x11-libs/cairo-1.12.2[X,xcb]
	)"
DEPEND="${CDEPEND}
	virtual/pkgconfig
	sys-devel/flex
	sys-devel/bison"
#docs? ( perl-core/Pod-Simple
#	app-text/xmlto
#	app-text/asciidoc
#)
RDEPEND="${CDEPEND}
	x11-apps/xmessage"

DOCS=( RELEASE-NOTES-${PV} )

src_prepare() {
	if ! use pango; then
		sed -i common.mk -e '/PANGO/d' || die
	fi

	sed -e "s/ar rcs/$(tc-getAR) rcs/" \
		-i libi3/libi3.mk || die #447496

	cat <<- EOF > "${T}"/i3wm
		#!/bin/sh
		exec /usr/bin/i3
	EOF
}

src_compile() {
	emake V=1 CC="$(tc-getCC)"
}

src_install() {
	default
	dohtml -r docs/*
	doman man/*.1
	exeinto /etc/X11/Sessions
	doexe "${T}"/i3wm
}

pkg_postinst() {
	einfo "There are several packages that you may find useful with ${PN} and"
	einfo "their usage is suggested by the upstream maintainers, namely:"
	einfo "  x11-misc/dmenu"
	einfo "  x11-misc/i3status"
	einfo "  x11-misc/i3lock"
	einfo "Please refer to their description for additional info."
}
