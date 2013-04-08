# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-vim/taglist/taglist-4.6.ebuild,v 1.2 2013/04/08 08:21:02 nimiux Exp $

EAPI=5

inherit vim-plugin eutils

DESCRIPTION="vim plugin: ctags-based source code browser"
HOMEPAGE="http://vim-taglist.sourceforge.net/"
LICENSE="vim"
KEYWORDS="~alpha amd64 ~hppa ~ia64 ~mips ~ppc ~sparc ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris"

RDEPEND="dev-util/ctags"

VIM_PLUGIN_HELPFILES="${PN}.txt"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-3.4-ebuilds.patch
}
