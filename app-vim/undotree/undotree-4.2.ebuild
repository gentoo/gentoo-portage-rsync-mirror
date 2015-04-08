# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-vim/undotree/undotree-4.2.ebuild,v 1.1 2013/01/13 09:56:19 radhermit Exp $

EAPI=5
VIM_PLUGIN_VIM_VERSION="7.3"

inherit vim-plugin vcs-snapshot

DESCRIPTION="vim plugin: display your undo history in a graph"
HOMEPAGE="http://www.vim.org/scripts/script.php?script_id=4177 https://github.com/mbbill/undotree"
SRC_URI="https://github.com/mbbill/${PN}/archive/rel_${PV}.tar.gz -> ${P}.tar.gz"
LICENSE="BSD"
KEYWORDS="~amd64 ~x86"
IUSE=""
