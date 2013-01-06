# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-vim/vim-latex/vim-latex-1.8.23.20110214.ebuild,v 1.4 2011/07/23 18:04:26 armin76 Exp $

EAPI=3

inherit vim-plugin versionator

MY_REV="1049-git089726a"
MY_P="${PN}-$( replace_version_separator 3 - ).${MY_REV}"

DESCRIPTION="vim plugin: a comprehensive set of tools to view, edit and compile LaTeX documents"
HOMEPAGE="http://vim-latex.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

LICENSE="vim"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris"
IUSE="html"

RDEPEND="virtual/latex-base"

S="${WORKDIR}/${MY_P}"

VIM_PLUGIN_HELPFILES="latex-suite.txt latex-suite-quickstart.txt latexhelp.txt imaps.txt"

src_prepare() {
	# The makefiles do weird stuff, including running the svn command
	rm Makefile Makefile.in || die "rm Makefile Makefile.in failed"
}

src_install() {
	use html && dohtml -r doc/

	# Don't mess up vim's doc dir with random files
	mv doc mydoc || die
	mkdir doc || die
	mv mydoc/*.txt doc/ || die
	rm -rf mydoc || die

	# Don't install buggy tags scripts, use ctags instead
	rm latextags ltags || die

	vim-plugin_src_install

	# Use executable permissions (bug #352403)
	fperms a+x /usr/share/vim/vimfiles/ftplugin/latex-suite/outline.py
}

pkg_postinst() {
	vim-plugin_pkg_postinst
	elog
	elog "To use the vim-latex plugin add:"
	elog "   filetype plugin on"
	elog '   set grepprg=grep\ -nH\ $*'
	elog "   let g:tex_flavor='latex'"
	elog "to your ~/.vimrc-file"
	elog
}
