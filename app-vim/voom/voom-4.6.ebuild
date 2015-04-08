# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-vim/voom/voom-4.6.ebuild,v 1.1 2013/01/13 19:04:02 radhermit Exp $

EAPI="5"

inherit vim-plugin

DESCRIPTION="vim plugin: emulates a two-pane text outliner"
HOMEPAGE="http://vim-voom.github.com/ http://www.vim.org/scripts/script.php?script_id=2657"
LICENSE="WTFPL-2"
KEYWORDS="~amd64 ~x86"
IUSE=""

VIM_PLUGIN_HELPFILES="${PN}.txt"

RDEPEND="|| ( app-editors/vim[python] app-editors/gvim[python] )"
