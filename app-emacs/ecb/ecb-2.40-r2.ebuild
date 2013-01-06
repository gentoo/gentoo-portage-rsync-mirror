# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/ecb/ecb-2.40-r2.ebuild,v 1.5 2012/09/29 07:49:04 ulm Exp $

EAPI=4

inherit elisp eutils

DESCRIPTION="Source code browser for Emacs"
HOMEPAGE="http://ecb.sourceforge.net/"
SRC_URI="mirror://sourceforge/ecb/${P}.tar.gz"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="amd64 ppc x86 ~amd64-linux ~x86-linux ~ppc-macos"
IUSE="java"

DEPEND=">=app-emacs/cedet-1.0_pre6
	java? ( app-emacs/jde )"
RDEPEND="${DEPEND}"

SITEFILE="70${PN}-gentoo.el"

src_prepare() {
	epatch "${FILESDIR}/${PN}-2.32-gentoo.patch"
	epatch "${FILESDIR}/${P}-cedet-version.patch"
	epatch "${FILESDIR}/${P}-emacs-24.patch"
	sed -i -e "s:@PF@:${PF}:" ecb-help.el || die "sed failed"
}

src_compile() {
	local loadpath="" sl=${EPREFIX}${SITELISP}
	if use java; then
		loadpath="${sl}/elib ${sl}/jde ${sl}/jde/lisp"
	fi

	emake CEDET="${sl}/cedet" LOADPATH="${loadpath}"
}

src_install() {
	elisp_src_install

	insinto "${SITEETC}/${PN}"
	doins -r ecb-images

	doinfo info-help/ecb.info*
	dohtml html-help/*.html
	dodoc NEWS README RELEASE_NOTES
}

pkg_postinst() {
	elisp-site-regen
	elog "ECB is now autoloaded in site-gentoo.el. Add the line"
	elog "  (require 'ecb)"
	elog "to your ~/.emacs file to enable all features on Emacs startup."
}
