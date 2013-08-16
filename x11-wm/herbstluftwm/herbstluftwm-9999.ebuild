# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/herbstluftwm/herbstluftwm-9999.ebuild,v 1.8 2013/08/16 16:12:45 radhermit Exp $

EAPI=5

inherit toolchain-funcs bash-completion-r1 git-2

EGIT_REPO_URI="git://git.informatik.uni-erlangen.de/re06huxa/herbstluftwm"

DESCRIPTION="A manual tiling window manager for X"
HOMEPAGE="http://herbstluftwm.org"

LICENSE="BSD-2"
SLOT="0"
IUSE="examples xinerama zsh-completion"

CDEPEND=">=dev-libs/glib-2.24:2
	x11-libs/libX11
	xinerama? ( x11-libs/libXinerama )"
RDEPEND="${CDEPEND}
	app-shells/bash
	zsh-completion? ( app-shells/zsh )"
DEPEND="${CDEPEND}
	app-text/asciidoc
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
