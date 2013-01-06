# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/mell/mell-1.0.0-r1.ebuild,v 1.7 2009/08/31 17:56:34 ranger Exp $

inherit elisp

DESCRIPTION="M Emacs Lisp Library"
HOMEPAGE="http://taiyaki.org/elisp/mell/"
SRC_URI="http://taiyaki.org/elisp/mell/src/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ppc ppc64 x86"
IUSE="linguas_ja"

SITEFILE="50${PN}-gentoo.el"

src_compile() {
	cd src
	elisp_src_compile
}

src_install() {
	cd src
	elisp_src_install
	cd ..
	dodoc README AUTHORS ChangeLog || die

	if use linguas_ja; then
		dohtml doc/index.html || die
	fi
}
