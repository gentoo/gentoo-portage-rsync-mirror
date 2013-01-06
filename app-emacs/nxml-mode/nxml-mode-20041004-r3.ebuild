# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/nxml-mode/nxml-mode-20041004-r3.ebuild,v 1.10 2012/09/25 14:01:47 ulm Exp $

EAPI=2

inherit elisp eutils

DESCRIPTION="A major mode for GNU Emacs for editing XML documents."
HOMEPAGE="http://www.thaiopensource.com/nxml-mode/
http://www.emacswiki.org/cgi-bin/wiki/NxmlMode"
SRC_URI="http://thaiopensource.com/download/${P}.tar.gz
	mirror://gentoo/${PN}-20040910-xmlschema.patch.gz"

LICENSE="GPL-2+ HPND W3C"
SLOT="0"
KEYWORDS="alpha amd64 ppc x86 ~sparc-fbsd ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris"
IUSE=""

SITEFILE=50${PN}-gentoo.el

src_prepare() {
	epatch "${FILESDIR}/${PN}-info-gentoo.patch"
	epatch "${WORKDIR}/${PN}-20040910-xmlschema.patch"
	epatch "${FILESDIR}/xsd-regexp.el.2006-01-26.patch"		# bug #188112
	epatch "${FILESDIR}/${PN}-xmlschema-xpath.patch"		# bug #188114
}

src_compile() {
	emacs -batch -l rng-auto.el -f rng-byte-compile-load \
		|| die
	makeinfo --force nxml-mode.texi || die
}

src_install() {
	elisp-install ${PN} *.el *.elc || die
	elisp-site-file-install "${FILESDIR}/${SITEFILE}" \
		|| die
	insinto ${SITELISP}/${PN}
	doins -r char-name || die
	insinto ${SITEETC}/${PN}
	doins -r schema || die
	doinfo nxml-mode.info
	dodoc README VERSION TODO NEWS || die
}
