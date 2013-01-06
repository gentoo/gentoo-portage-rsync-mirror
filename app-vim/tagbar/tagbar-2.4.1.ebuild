# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-vim/tagbar/tagbar-2.4.1.ebuild,v 1.1 2012/08/03 09:47:41 radhermit Exp $

EAPI="4"

inherit vim-plugin vcs-snapshot

DESCRIPTION="vim plugin: display tags of the current file ordered by scope"
HOMEPAGE="http://majutsushi.github.com/tagbar/
	http://www.vim.org/scripts/script.php?script_id=3465"
SRC_URI="http://github.com/majutsushi/${PN}/tarball/v${PV} -> ${P}.tar.gz"
LICENSE="vim"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-util/ctags-5.5"

VIM_PLUGIN_HELPFILES="${PN}.txt"
