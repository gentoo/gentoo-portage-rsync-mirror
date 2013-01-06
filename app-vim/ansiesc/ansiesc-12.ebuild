# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-vim/ansiesc/ansiesc-12.ebuild,v 1.1 2011/03/11 09:39:17 radhermit Exp $

EAPI=3
VIM_PLUGIN_VIM_VERSION="7.3"

inherit vim-plugin

DESCRIPTION="vim plugin: ansi escape sequences concealed, but highlighted as specified"
HOMEPAGE="http://www.vim.org/scripts/script.php?script_id=302"
LICENSE="public-domain"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="app-vim/cecutil"

VIM_PLUGIN_HELPFILES="AnsiEsc.txt"
