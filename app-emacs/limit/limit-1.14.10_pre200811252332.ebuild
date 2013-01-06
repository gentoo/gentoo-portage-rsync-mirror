# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/limit/limit-1.14.10_pre200811252332.ebuild,v 1.6 2009/07/16 16:42:57 nixnut Exp $

inherit elisp versionator

MY_PV=( $(get_version_components) )
MY_P="${PN}-${MY_PV[0]}_${MY_PV[1]}-${MY_PV[3]#pre}"

DESCRIPTION="Library about Internet Message, for IT generation"
HOMEPAGE="http://cvs.m17n.org/elisp/FLIM/"
SRC_URI="http://www.jpl.org/ftp/pub/m17n/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ppc sparc x86"
IUSE=""

DEPEND=">=app-emacs/apel-10.3"
RDEPEND="${DEPEND}
	!app-emacs/flim"

S="${WORKDIR}/${MY_P}"
SITEFILE="60flim-gentoo.el"

src_compile() {
	emake PREFIX="${D}/usr" \
		LISPDIR="${D}/${SITELISP}" \
		VERSION_SPECIFIC_LISPDIR="${D}/${SITELISP}" || die "emake failed"
}

src_install() {
	emake PREFIX="${D}/usr" \
		LISPDIR="${D}/${SITELISP}" \
		VERSION_SPECIFIC_LISPDIR="${D}/${SITELISP}" install \
		|| die "emake install failed"

	elisp-site-file-install "${FILESDIR}/${SITEFILE}" || die

	dodoc FLIM-API.en NEWS VERSION README* ChangeLog || die "dodoc failed"
}
