# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/emms/emms-3.0.ebuild,v 1.3 2009/05/05 07:55:53 fauli Exp $

NEED_EMACS=22

inherit elisp toolchain-funcs eutils

DESCRIPTION="The Emacs Multimedia System"
HOMEPAGE="http://www.gnu.org/software/emms/
	http://www.emacswiki.org/cgi-bin/wiki/EMMS"
SRC_URI="http://www.gnu.org/software/emms/download/${P}.tar.gz"

LICENSE="GPL-3 FDL-1.1"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64 ~sparc"
IUSE=""

DEPEND="media-libs/taglib"
RDEPEND="${DEPEND}"

# EMMS can use almost anything for playing media files therefore the dependency
# possibilities are so broad that we refrain from setting anything explicitly
# in DEPEND/RDEPEND.

SITEFILE=50${PN}-gentoo.el

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/2.0-taglib-Makefile-gentoo.patch"
}

src_compile() {
	emake CC="$(tc-getCC)" \
		EMACS=emacs \
		all emms-print-metadata \
		|| die "emake failed"
}

src_install() {
	elisp-install ${PN} *.{el,elc}
	elisp-site-file-install "${FILESDIR}/${SITEFILE}"
	doinfo *.info*
	dobin *-wrapper emms-print-metadata
	dodoc AUTHORS ChangeLog FAQ NEWS README RELEASE || die "dodoc failed"
}
