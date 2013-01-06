# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-vim/csv/csv-0.26.ebuild,v 1.1 2012/08/03 10:38:47 radhermit Exp $

EAPI="4"
VIM_PLUGIN_VIM_VERSION="7.3"

inherit vim-plugin

DESCRIPTION="vim plugin: display and alter csv files"
HOMEPAGE="http://www.vim.org/scripts/script.php?script_id=2830"
LICENSE="vim"
KEYWORDS="~amd64 ~x86"
IUSE=""

VIM_PLUGIN_HELPFILES="ft-csv.txt"
