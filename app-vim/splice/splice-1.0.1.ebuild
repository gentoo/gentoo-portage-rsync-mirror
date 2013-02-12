# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-vim/splice/splice-1.0.1.ebuild,v 1.1 2013/02/12 10:19:42 radhermit Exp $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7} )

inherit vim-plugin python-single-r1

DESCRIPTION="vim plugin: resolve conflicts during three-way merges"
HOMEPAGE="http://sjl.bitbucket.org/splice.vim/ http://vim.sourceforge.net/scripts/script.php?script_id=4026"
LICENSE="MIT"
KEYWORDS="~amd64 ~x86"

RDEPEND="|| ( app-editors/vim[python] app-editors/gvim[python] )"

VIM_PLUGIN_HELPFILES="${PN}.txt"

src_prepare() {
	rm LICENSE.markdown || die
}

src_install() {
	vim-plugin_src_install
	python_optimize "${ED}"/usr/share/vim/vimfiles/autoload/splicelib
}
