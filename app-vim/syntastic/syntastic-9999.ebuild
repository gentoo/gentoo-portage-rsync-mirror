# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-vim/syntastic/syntastic-9999.ebuild,v 1.1 2013/07/24 08:12:23 radhermit Exp $

EAPI=5
inherit vim-plugin git-2

EGIT_REPO_URI="git://github.com/scrooloose/syntastic.git"

DESCRIPTION="vim plugin: syntax checking using external tools"
HOMEPAGE="http://www.vim.org/scripts/script.php?script_id=2736 https://github.com/scrooloose/syntastic/"
LICENSE="WTFPL-2"

VIM_PLUGIN_HELPFILES="${PN}"

src_prepare() {
	rm -r _assets LICENCE README.markdown || die
}

pkg_postinst() {
	if [[ -z ${REPLACING_VERSIONS} ]] ; then
		elog "Syntastic has many optional dependencies depending on the type"
		elog "of syntax checking being performed. Look in the related files in"
		elog "the syntax_checkers directory to help figure out what programs"
		elog "different languages need."
	fi
}
