# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-vim/nerdcommenter/nerdcommenter-2.3.0.ebuild,v 1.1 2010/12/09 19:47:42 radhermit Exp $

EAPI=2

VIM_PLUGIN_VIM_VERSION=7.0
inherit vim-plugin

DESCRIPTION="vim plugin: easy commenting of code for many filetypes."
HOMEPAGE="http://www.vim.org/scripts/script.php?script_id=1218"
SRC_URI="http://www.vim.org/scripts/download_script.php?src_id=14455 -> ${P}.zip"
LICENSE="public-domain"
KEYWORDS="~amd64 ~x86 ~x86-linux ~x86-macos ~sparc64-solaris"
IUSE=""

VIM_PLUGIN_HELPFILES="NERD_commenter"

DEPEND="app-arch/unzip"
RDEPEND=""

S="${WORKDIR}"
