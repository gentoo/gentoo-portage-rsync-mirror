# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/vm/vm-7.19-r4.ebuild,v 1.7 2013/04/04 21:17:46 ulm Exp $

inherit elisp eutils

DESCRIPTION="An emacs major mode for reading and writing e-mail with support for GPG and MIME."
HOMEPAGE="http://www.wonderworks.com/vm/"
SRC_URI="ftp://ftp.uni-mainz.de/pub/software/gnu/${PN}/${P}.tar.gz
	ftp://ftp.uu.net/networking/mail/${PN}/${P}.tar.gz"

LICENSE="GPL-1+"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

SITEFILE="50${PN}-gentoo-${PV}.el"

src_unpack() {
	unpack ${A}

	cd "${S}"
	epatch "${FILESDIR}/vm-info-dir-fix-gentoo.patch"
	epatch "${FILESDIR}/${P}-burst-digest.patch"
	epatch "${FILESDIR}/${P}-gcc4.patch"
	epatch "${FILESDIR}/${P}-install-info.patch"
}

src_compile() {
	make prefix="${D}/usr" \
		INFODIR="${D}/usr/share/info" \
		LISPDIR="${D}${SITELISP}/${PN}" \
		PIXMAPDIR="${D}${SITEETC}/${PN}" \
		all || die
}

src_install() {
	make prefix="${D}/usr" \
		INFODIR="${D}/usr/share/info" \
		LISPDIR="${D}${SITELISP}/${PN}" \
		PIXMAPDIR="${D}${SITEETC}/${PN}" \
		install || die
	elisp-install ${PN} *.el
	elisp-site-file-install "${FILESDIR}/${SITEFILE}"
	dodoc README
}
