# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-doc/elisp-manual/elisp-manual-21.2.8-r2.ebuild,v 1.11 2012/07/29 17:34:55 armin76 Exp $

inherit eutils

MY_P=${PN}-${PV/./-}
DESCRIPTION="The GNU Emacs Lisp Reference Manual"
HOMEPAGE="http://www.gnu.org/software/emacs/manual/"
SRC_URI="mirror://gnu/emacs/${MY_P}.tar.gz
	mirror://gentoo/${P}-patches.tar.gz"

LICENSE="FDL-1.1"
SLOT="21"
KEYWORDS="amd64 ppc x86"
IUSE=""

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	# remove pre-made info files
	rm -f elisp elisp-[0-9]*
	EPATCH_SUFFIX=patch epatch
}

src_compile() {
	ln -s index.unperm index.texi
	makeinfo elisp.texi || die "makeinfo failed"
}

src_install() {
	doinfo elisp21.info* || die "doinfo failed"
	dodoc README
}
