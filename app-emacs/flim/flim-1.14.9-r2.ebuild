# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/flim/flim-1.14.9-r2.ebuild,v 1.6 2011/05/10 10:25:02 naota Exp $

EAPI=3

inherit elisp

DESCRIPTION="A library to provide basic features about message representation or encoding"
HOMEPAGE="http://cvs.m17n.org/elisp/FLIM/"
SRC_URI="http://www.kanji.zinbun.kyoto-u.ac.jp/~tomo/lemi/dist/flim/${P%.*}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ppc sparc x86 ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris"
IUSE=""

DEPEND=">=app-emacs/apel-10.3"
RDEPEND="${DEPEND}
	!app-emacs/limit"

ELISP_PATCHES="${P}-mel-q-ccl.patch"
SITEFILE="60${PN}-gentoo.el"

src_compile() {
	emake PREFIX="${ED}/usr" \
		LISPDIR="${ED}/${SITELISP}" \
		VERSION_SPECIFIC_LISPDIR="${ED}/${SITELISP}" || die "emake failed"
}

src_install() {
	emake PREFIX="${ED}/usr" \
		LISPDIR="${ED}/${SITELISP}" \
		VERSION_SPECIFIC_LISPDIR="${ED}/${SITELISP}" install \
		|| die "emake install failed"

	elisp-site-file-install "${FILESDIR}/${SITEFILE}" || die

	dodoc FLIM-API.en NEWS VERSION README* ChangeLog || die "dodoc failed"
}
