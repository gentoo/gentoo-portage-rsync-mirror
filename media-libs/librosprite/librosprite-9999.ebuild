# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/librosprite/librosprite-9999.ebuild,v 1.3 2013/02/28 08:09:05 xmw Exp $

EAPI=5

inherit git-2 multilib toolchain-funcs

DESCRIPTION="framebuffer abstraction library, written in C"
HOMEPAGE="http://www.netsurf-browser.org/projects/librosprite/"
EGIT_REPO_URI="git://git.netsurf-browser.org/${PN}.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="media-libs/libsdl"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_prepare() {
	sed -e '/^\(C\|LD\)FLAGS = -g /s:= -g :+= :' \
		-e "/^CC =/s:=.*:= $(tc-getCC):" \
		-e "/^LD =/s:=.*:= $(tc-getCC):" \
		-e "/^AR =/s:=.*:= $(tc-getAR):" \
	-e "/^PREFIX ?=/s:=.*:= /usr:" \
		-e "/^install/,/^uninstall/s:/lib:/$(get_libdir):" \
		-i Makefile || die
	sed -e "/^libdir/s:/lib:/$(get_libdir):g" \
		-i ${PN}.pc.in || die
}
