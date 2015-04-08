# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-vim/voom/voom-4.7.ebuild,v 1.2 2013/02/07 21:47:26 ulm Exp $

EAPI=5

inherit vim-plugin

DESCRIPTION="vim plugin: emulates a two-pane text outliner"
HOMEPAGE="http://vim-voom.github.com/ http://www.vim.org/scripts/script.php?script_id=2657"
LICENSE="CC0-1.0"
KEYWORDS="~amd64 ~x86"

VIM_PLUGIN_HELPFILES="${PN}.txt"

RDEPEND="|| ( app-editors/vim[python] app-editors/gvim[python] )"

src_prepare() {
	rm -r voom_extras || die
}
