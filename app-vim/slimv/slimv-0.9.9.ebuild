# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-vim/slimv/slimv-0.9.9.ebuild,v 1.1 2012/12/03 19:23:33 radhermit Exp $

EAPI=5

inherit vim-plugin

DESCRIPTION="vim plugin: aid Lisp development by providing a SLIME-like Lisp and Clojure REPL"
HOMEPAGE="http://www.vim.org/scripts/script.php?script_id=2531"
LICENSE="public-domain"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="|| ( app-editors/vim[python] app-editors/gvim[python] )
	>=dev-lang/python-2.4
	|| (
		dev-lisp/clisp
		dev-lang/clojure
		dev-lisp/abcl
		dev-lisp/clozurecl
		dev-lisp/ecls
		dev-lisp/sbcl
	)"

VIM_PLUGIN_HELPFILES="${PN}.txt"

src_prepare() {
	# remove emacs related files
	rm -r slime swank-clojure || die
}
