# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-vim/supertab/supertab-2.1.ebuild,v 1.1 2014/04/12 22:01:04 radhermit Exp $

EAPI="5"

inherit vim-plugin

DESCRIPTION="vim plugin: enhanced Tab key functionality"
HOMEPAGE="http://www.vim.org/scripts/script.php?script_id=1643"
SRC_URI="https://github.com/ervandew/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
LICENSE="BSD"
KEYWORDS="~amd64 ~mips ~ppc ~x86"

VIM_PLUGIN_HELPFILES="${PN}.txt"

src_prepare() {
	rm Makefile .gitignore || die
}
