# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-vim/csv/csv-0.28.ebuild,v 1.1 2013/01/13 09:13:19 radhermit Exp $

EAPI="5"
VIM_PLUGIN_VIM_VERSION="7.3"

inherit vim-plugin

DESCRIPTION="vim plugin: display and alter csv files"
HOMEPAGE="http://www.vim.org/scripts/script.php?script_id=2830"
LICENSE="vim"
KEYWORDS="~amd64 ~x86"
IUSE=""

VIM_PLUGIN_HELPFILES="ft-csv.txt"
