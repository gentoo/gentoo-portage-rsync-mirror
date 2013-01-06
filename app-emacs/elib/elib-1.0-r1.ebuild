# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/elib/elib-1.0-r1.ebuild,v 1.4 2012/01/15 15:53:12 phajdan.jr Exp $

EAPI=3

inherit elisp

DESCRIPTION="The Emacs Lisp Library"
HOMEPAGE="http://jdee.sourceforge.net"
SRC_URI="http://jdee.sunsite.dk/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris"
IUSE=""

SITEFILE="50${PN}-gentoo.el"

src_prepare() {
	sed -i 's:--infodir:--info-dir:g' Makefile || die
}

# This is NOT redundant, elisp.eclass redefines src_compile
src_compile() {
	emake || die "emake failed"
}

src_install() {
	dodir "${SITELISP}/elib"
	dodir /usr/share/info
	emake prefix="${ED}/usr" infodir="${ED}/usr/share/info" install \
		|| die "emake install failed"
	elisp-site-file-install "${FILESDIR}/${SITEFILE}" || die
	dodoc ChangeLog NEWS README TODO || die "dodoc failed"
}
