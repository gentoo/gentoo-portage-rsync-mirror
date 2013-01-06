# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-vim/undotree/undotree-4.1.ebuild,v 1.1 2012/09/09 11:03:15 radhermit Exp $

EAPI=4
VIM_PLUGIN_VIM_VERSION="7.3"

inherit vim-plugin vcs-snapshot

DESCRIPTION="vim plugin: display your undo history in a graph"
HOMEPAGE="http://www.vim.org/scripts/script.php?script_id=4177 https://github.com/mbbill/undotree"
SRC_URI="https://github.com/mbbill/${PN}/tarball/rel_${PV} -> ${P}.tar.gz"
LICENSE="BSD"
KEYWORDS="~amd64 ~x86"
IUSE=""
