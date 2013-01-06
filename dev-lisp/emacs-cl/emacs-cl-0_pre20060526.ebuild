# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/emacs-cl/emacs-cl-0_pre20060526.ebuild,v 1.3 2012/09/05 17:06:16 mr_bones_ Exp $

#ECVS_SERVER="cvs.nocrew.org:/usr/local/cvsroot"
#ECVS_MODULE="emacs-cl"

inherit elisp

DESCRIPTION="An implementation of Common Lisp written in Emacs Lisp"
HOMEPAGE="http://www.lisp.se/emacs-cl/
	http://www.emacswiki.org/cgi-bin/wiki?EmacsCommonLisp
	http://www.cliki.net/emacs-cl"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

S="${WORKDIR}/${PN}"
SITEFILE="50${PN}-gentoo.el"
DOCS="BUGS HACKING HOWTO README"

src_compile() {
	emake EMACS="${EMACS}" || die "emake failed"
}

src_test() {
	# "make check" clears all *.elc files, so move them to a safe location
	mkdir safe || die "mkdir failed"
	mv *.elc safe || die "mv failed"
	emake -j1 check EMACSEN="${EMACS}" || die "emake check failed"
	mv safe/*.elc . || die "mv failed"
}

src_install() {
	elisp_src_install

	sed 's/^X//' >"${T}/emacs-cl" <<-EOF
	#!/bin/sh
	exec ${EMACS} -batch \\
	X    -l ${SITELISP}/${PN}/load-cl.el \\
	X    -l ${SITELISP}/${PN}/batch.el \\
	X    -f batch-repl
	EOF
	dobin "${T}/emacs-cl" || die "dobin failed"
}
