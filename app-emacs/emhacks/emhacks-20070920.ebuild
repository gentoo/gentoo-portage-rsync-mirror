# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/emhacks/emhacks-20070920.ebuild,v 1.2 2008/08/27 07:32:44 ulm Exp $

inherit elisp

DESCRIPTION="Useful Emacs Lisp libraries, including gdiff, jjar, jmaker, swbuff, and tabbar"
HOMEPAGE="http://emhacks.sourceforge.net/"
# CVS snapshot
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="jde"

DEPEND="jde? ( app-emacs/jde )"
RDEPEND="${DEPEND}"

SITEFILE=50${PN}-gentoo.el

src_unpack() {
	unpack ${A}
	cd "${S}"
	# remove files included in Emacs>=22 or not useful on GNU/Linux
	rm -r findstr* overlay-fix* recentf* ruler-mode* tree-widget*
	# this requires jde and cedet, not everyone may want it
	use jde || rm jsee.el
}

src_install() {
	elisp-install ${PN} *.el *.elc || die "elisp-install failed"

	cp "${FILESDIR}/${SITEFILE}" "${T}"
	use jde || sed -i -e '/;; jsee/,$d' "${T}/${SITEFILE}"
	elisp-site-file-install "${T}/${SITEFILE}" \
		|| die "elisp-site-file-install failed"

	dodoc Changelog || die "dodoc failed"
}
