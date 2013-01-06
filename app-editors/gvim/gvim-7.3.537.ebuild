# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/gvim/gvim-7.3.537.ebuild,v 1.1 2012/06/05 13:26:18 lack Exp $

EAPI=3
VIM_VERSION="7.3"
inherit vim

VIM_ORG_PATCHES="vim-patches-${PV}.patch.bz2"
GVIMRC_FILE_SUFFIX="-r1"
GVIM_DESKTOP_SUFFIX="-r2"

SRC_URI="ftp://ftp.vim.org/pub/vim/unix/vim-${VIM_VERSION}.tar.bz2
	http://dev.gentoo.org/~lack/vim/${VIM_ORG_PATCHES}"

S="${WORKDIR}/vim${VIM_VERSION/.}"
DESCRIPTION="GUI version of the Vim text editor"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~x86-solaris"
IUSE=""

src_prepare() {
	vim_src_prepare

	epatch "${FILESDIR}"/${PN}-7.1.285-darwin-x11link.patch
	if [[ ${CHOST} == *-interix* ]]; then
		epatch "${FILESDIR}"/${PN}-7.1-interix-link.patch
		epatch "${FILESDIR}"/${PN}-7.1.319-interix-cflags.patch
	fi
}
