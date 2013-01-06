# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-vim/gitv/gitv-1.0-r1.ebuild,v 1.1 2011/05/04 11:30:29 radhermit Exp $

EAPI="4"
VIM_PLUGIN_VIM_VERSION="7.2"

inherit vim-plugin

DESCRIPTION="vim plugin: gitk for vim"
HOMEPAGE="http://www.vim.org/scripts/script.php?script_id=3574"
SRC_URI="http://www.vim.org/scripts/download_script.php?src_id=15572 -> ${P}.zip"
LICENSE="vim"
KEYWORDS="~amd64 ~x86"
IUSE=""

VIM_PLUGIN_HELPFILES="gitv"

DEPEND="app-arch/unzip"
RDEPEND="dev-vcs/git
	app-vim/fugitive"

src_prepare() {
	# Remove .DS_Store files that should not be installed
	find -type f -name '.*' -exec rm -f {} + || die
}
