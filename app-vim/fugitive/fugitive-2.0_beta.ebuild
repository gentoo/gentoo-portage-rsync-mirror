# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-vim/fugitive/fugitive-2.0_beta.ebuild,v 1.1 2014/06/19 05:32:13 radhermit Exp $

EAPI=5

inherit vim-plugin vcs-snapshot

DESCRIPTION="vim plugin: a git wrapper for vim"
HOMEPAGE="http://www.vim.org/scripts/script.php?script_id=2975 https://github.com/tpope/vim-fugitive/"
SRC_URI="https://github.com/tpope/vim-fugitive/archive/v2.0.beta.tar.gz -> ${P}.tar.gz"
LICENSE="vim"
KEYWORDS="~amd64 ~x86 ~ppc-macos ~x64-macos"

VIM_PLUGIN_HELPFILES="${PN}.txt"

RDEPEND="dev-vcs/git"
