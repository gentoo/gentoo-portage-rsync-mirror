# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-vim/bufexplorer/bufexplorer-7.3.6.ebuild,v 1.1 2013/08/20 01:29:16 radhermit Exp $

EAPI=5

inherit vim-plugin

DESCRIPTION="vim plugin: easily browse vim buffers"
HOMEPAGE="http://www.vim.org/scripts/script.php?script_id=42"
SRC_URI="http://www.vim.org/scripts/download_script.php?src_id=20031 -> ${P}.zip"
LICENSE="bufexplorer.vim"
KEYWORDS="~amd64 ~x86"

S=${WORKDIR}

VIM_PLUGIN_HELPFILES="${PN}"

DEPEND="app-arch/unzip"
