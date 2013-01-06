# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-filter/libsieve/libsieve-2.2.7.ebuild,v 1.6 2012/02/16 18:44:55 phajdan.jr Exp $

DESCRIPTION="A library for parsing, sorting and filtering your mail."
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://libsieve.sourceforge.net/"

SLOT="0"
LICENSE="MIT LGPL-2"
KEYWORDS="~alpha amd64 ~ppc ~sparc x86"
IUSE=""

DEPEND=""
RDEPEND="!<net-mail/mailutils-2.1"

src_compile() {
	cd "${S}"/src
	econf || die "econf failed"
	emake || die "emake failed"
}

src_install () {
	cd "${S}"/src
	emake DESTDIR="${D}" install || die "emake install failed"
}
