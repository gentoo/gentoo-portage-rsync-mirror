# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-vim/bufexplorer/bufexplorer-7.2.8.ebuild,v 1.1 2013/02/12 11:08:01 radhermit Exp $

EAPI="2"

VIM_PLUGIN_VIM_VERSION="7.0"
inherit vim-plugin

DESCRIPTION="vim plugin: easily browse vim buffers"
HOMEPAGE="http://www.vim.org/scripts/script.php?script_id=42"
SRC_URI="http://www.vim.org/scripts/download_script.php?src_id=14208 -> ${P}.zip"
LICENSE="bufexplorer.vim"
KEYWORDS="~amd64 ~x86"
IUSE=""

S="${WORKDIR}"

VIM_PLUGIN_HELPFILES="bufexplorer"

DEPEND="app-arch/unzip"
RDEPEND=""
