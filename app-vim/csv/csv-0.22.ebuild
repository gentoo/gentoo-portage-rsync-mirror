# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-vim/csv/csv-0.22.ebuild,v 1.1 2011/11/13 20:07:28 radhermit Exp $

EAPI="4"
VIM_PLUGIN_VIM_VERSION="7.3"

inherit vim-plugin

MY_PN="csv.vim"
DESCRIPTION="vim plugin: display and alter csv files"
HOMEPAGE="http://www.vim.org/scripts/script.php?script_id=2830"
SRC_URI="https://github.com/vim-scripts/${MY_PN}/tarball/${PV:2:2} -> ${P}.tar.gz"
LICENSE="vim"
KEYWORDS="~amd64 ~x86"
IUSE=""

VIM_PLUGIN_HELPFILES="ft-csv.txt"

src_unpack() {
	unpack ${A}
	mv *-${MY_PN}-* "${S}"
}

src_prepare() {
	rm README || die
}
