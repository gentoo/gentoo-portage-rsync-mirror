# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/doxymacs/doxymacs-1.8.0-r3.ebuild,v 1.3 2009/06/11 19:36:46 maekke Exp $

NEED_EMACS=22

inherit elisp flag-o-matic

DESCRIPTION="Doxygen editing minor mode"
HOMEPAGE="http://doxymacs.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND=">=dev-libs/libxml2-2.6.13"
RDEPEND="${DEPEND}"

SITEFILE="50${PN}-gentoo.el"

src_compile() {
	append-flags -Wno-error		#260874
	econf --with-lispdir="${SITELISP}/${PN}" || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	elisp-site-file-install "${FILESDIR}/${SITEFILE}" || die
	dodoc AUTHORS ChangeLog NEWS README TODO || die "dodoc failed"
}
