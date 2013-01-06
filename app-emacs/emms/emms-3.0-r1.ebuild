# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/emms/emms-3.0-r1.ebuild,v 1.1 2010/08/09 20:19:30 ulm Exp $

NEED_EMACS=22

inherit elisp toolchain-funcs

DESCRIPTION="The Emacs Multimedia System"
HOMEPAGE="http://www.gnu.org/software/emms/
	http://www.emacswiki.org/cgi-bin/wiki/EMMS"
SRC_URI="http://www.gnu.org/software/emms/download/${P}.tar.gz"

LICENSE="GPL-3 FDL-1.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND="media-libs/taglib"
RDEPEND="${DEPEND}"

# EMMS can use almost anything for playing media files therefore the dependency
# possibilities are so broad that we refrain from setting anything explicitly
# in DEPEND/RDEPEND.

ELISP_PATCHES="${P}-Makefile.patch"
SITEFILE="50${PN}-gentoo.el"

src_compile() {
	emake CC="$(tc-getCC)" \
		EMACS=emacs \
		all emms-print-metadata || die
}

src_install() {
	elisp-install ${PN} *.{el,elc} || die
	elisp-site-file-install "${FILESDIR}/${SITEFILE}" || die
	doinfo *.info* || die
	dobin *-wrapper emms-print-metadata || die
	dodoc AUTHORS ChangeLog FAQ NEWS README RELEASE || die
}
