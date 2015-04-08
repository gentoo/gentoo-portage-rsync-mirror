# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/yasnippet/yasnippet-0.6.1c.ebuild,v 1.1 2009/10/15 18:00:20 ulm Exp $

inherit elisp

DESCRIPTION="Yet another snippet extension for Emacs"
HOMEPAGE="http://code.google.com/p/yasnippet/"
SRC_URI="http://yasnippet.googlecode.com/files/${P}.tar.bz2
	doc? ( http://yasnippet.googlecode.com/files/${PN}-doc-${PV}.tar.bz2 )"

# Homepage says MIT licence, source contains GPL-2 copyright notice
LICENSE="MIT GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

DEPEND=">=app-emacs/dropdown-list-20080316"
RDEPEND="${DEPEND}"

SITEFILE="50${PN}-gentoo.el"

src_unpack() {
	elisp_src_unpack

	# remove bundled copy of dropdown-list
	rm "${S}/dropdown-list.el" || die
}

src_install() {
	elisp_src_install

	insinto "${SITEETC}/${PN}"
	doins -r snippets || die "doins failed"

	if use doc; then
		dohtml -r "${WORKDIR}"/doc/* || die "dohtml failed"
	fi
}

pkg_postinst() {
	elisp-site-regen

	elog "Please add the following code into your .emacs to use yasnippet:"
	elog "(yas/initialize)"
	elog "(yas/load-directory \"${SITEETC}/${PN}/snippets\")"
}
