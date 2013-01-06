# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/cwm/cwm-9999.ebuild,v 1.4 2012/10/06 12:33:54 xmw Exp $

EAPI=4

inherit flag-o-matic toolchain-funcs git-2

DESCRIPTION="OpenBSD fork of calmwm, a clean and lightweight window manager"
HOMEPAGE="http://www.openbsd.org/cgi-bin/cvsweb/xenocara/app/cwm/
	http://github.com/chneukirchen/cwm"
EGIT_BRANCH=linux

LICENSE="ISC"
SLOT="0"
KEYWORDS=""
IUSE="vanilla"

RDEPEND="x11-libs/libXft
	x11-libs/libXinerama
	x11-libs/libXrandr"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	sys-devel/bison"

pkg_setup() {
	if use vanilla ; then
		EGIT_REPO_URI="https://github.com/chneukirchen/cwm.git"
	else
		EGIT_REPO_URI="https://github.com/xmw/cwm.git"
	fi
}

src_compile() {
	#append-cflags -D_GNU_SOURCE #bug 417047
	emake CFLAGS="${CFLAGS} -D_GNU_SOURCE" CC="$(tc-getCC)"
}

src_install() {
	emake DESTDIR="${D}" PREFIX=/usr install
	dodoc README
	make_session_desktop ${PN} ${PN}
}
