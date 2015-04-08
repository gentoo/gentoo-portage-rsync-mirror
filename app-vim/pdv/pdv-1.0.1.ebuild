# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-vim/pdv/pdv-1.0.1.ebuild,v 1.2 2012/10/19 19:13:32 ago Exp $

inherit vim-plugin

DESCRIPTION="vim plugin: PDV (phpDocumentor for Vim)"
HOMEPAGE="http://www.vim.org/scripts/script.php?script_id=1355"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE=""

VIM_PLUGIN_HELPTEXT="To use this plugin, you should map the PhpDoc() function
to something. For example, add the following to your ~/.vimrc:

imap <C-o> ^[:set paste<CR>:exe PhpDoc()<CR>:set nopaste<CR>i

For more info, see:
${HOMEPAGE}"
