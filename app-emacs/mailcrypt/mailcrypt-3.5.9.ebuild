# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/mailcrypt/mailcrypt-3.5.9.ebuild,v 1.5 2010/10/14 16:49:05 ranger Exp $

EAPI=3

inherit elisp autotools

DESCRIPTION="Provides a simple interface to public key cryptography with OpenPGP"
HOMEPAGE="http://mailcrypt.sourceforge.net/"
SRC_URI="mirror://sourceforge/mailcrypt/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc sparc x86"
IUSE=""
RESTRICT="test"

RDEPEND="app-crypt/gnupg"

SITEFILE="50${PN}-gentoo.el"

src_prepare() {
	eautoreconf
}

src_configure() {
	export EMACS=/usr/bin/emacs
	econf || die
}

src_install() {
	einstall lispdir="${D}/${SITELISP}/${PN}" || die "einstall failed"
	elisp-site-file-install "${FILESDIR}/${SITEFILE}"
	dodoc ANNOUNCE ChangeLog* INSTALL LCD-entry  NEWS ONEWS README* || die
}

pkg_postinst() {
	elisp-site-regen
	elog
	elog "See the INSTALL file in /usr/share/doc/${PF} for how to"
	elog "customize mailcrypt"
	elog
}
