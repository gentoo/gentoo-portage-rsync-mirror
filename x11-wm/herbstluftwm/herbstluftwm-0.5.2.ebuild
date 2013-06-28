# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/herbstluftwm/herbstluftwm-0.5.2.ebuild,v 1.1 2013/06/28 22:04:48 radhermit Exp $

EAPI=5

inherit toolchain-funcs bash-completion-r1

DESCRIPTION="A manual tiling window manager for X"
HOMEPAGE="http://wwwcip.cs.fau.de/~re06huxa/herbstluftwm/"
SRC_URI="http://wwwcip.cs.fau.de/~re06huxa/${PN}/tarballs/${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="examples xinerama zsh-completion"

CDEPEND=">=dev-libs/glib-2.24:2
	x11-libs/libX11
	xinerama? ( x11-libs/libXinerama )"
RDEPEND="${CDEPEND}
	app-shells/bash
	zsh-completion? ( app-shells/zsh )"
DEPEND="${CDEPEND}
	virtual/pkgconfig"

src_compile() {
	emake CC="$(tc-getCC)" LD="$(tc-getCC)" COLOR=0 VERBOSE= \
		$(use xinerama || echo XINERAMAFLAGS= XINERAMALIBS= )
}

src_install() {
	dobin herbstluftwm herbstclient
	dodoc BUGS MIGRATION NEWS README

	doman doc/{herbstluftwm,herbstclient}.1

	exeinto /etc/xdg/herbstluftwm
	doexe share/{autostart,panel.sh,restartpanels.sh}

	insinto /usr/share/xsessions
	doins share/herbstluftwm.desktop

	newbashcomp share/herbstclient-completion herbstclient

	if use zsh-completion ; then
		insinto /usr/share/zsh/site-functions
		doins share/_herbstclient
	fi

	if use examples ; then
		exeinto /usr/share/doc/${PF}/examples
		doexe scripts/*.sh
		docinto examples
		dodoc scripts/README
		docompress -x /usr/share/doc/${PF}/examples
	fi
}
