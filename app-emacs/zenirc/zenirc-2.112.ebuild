# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/zenirc/zenirc-2.112.ebuild,v 1.11 2007/11/20 13:07:11 opfer Exp $

inherit elisp

DESCRIPTION="A full-featured scriptable IRC client for the Emacs text editor."
HOMEPAGE="http://www.zenirc.org/"
SRC_URI="ftp://ftp.zenirc.org/pub/zenirc/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

SITEFILE=50zenirc-gentoo.el

src_compile() {
	./configure --prefix=/usr/ || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake prefix="${D}/usr" \
		infodir="${D}/usr/share/info" \
		elispdir="${D}/${SITELISP}/${PN}" \
		etcdir="${D}/usr/share/${PN}" install || die "emake install failed"

	elisp-install ${PN} src/*.el || die
	elisp-site-file-install "${FILESDIR}/${SITEFILE}" || die "elisp-site-file install failed"

	doinfo doc/zenirc.info
	dodoc BUGS INSTALL NEWS README TODO
	docinto doc
	dodoc doc/*

	elog "Refer to the Info documentation and ${SITELISP}/${PN}/zenirc-example.el for cusomtization hints"
}
