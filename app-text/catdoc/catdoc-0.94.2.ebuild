# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/catdoc/catdoc-0.94.2.ebuild,v 1.3 2008/08/17 17:21:31 maekke Exp $

DESCRIPTION="A convertor for Microsoft Word, Excel and RTF Files to text"
HOMEPAGE="http://www.wagner.pp.ru/~vitus/software/catdoc/"
SRC_URI="http://ftp.wagner.pp.ru/pub/${PN}/${P}.tar.gz"
LICENSE="GPL-2"

IUSE="tk"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"

DEPEND="tk? ( >=dev-lang/tk-8.1 )"

DOCS="CODING.STD CREDITS NEWS README TODO"

src_compile() {

	local myconf="--with-install-root=${D}"

	use tk \
		&& myconf="${myconf} --with-wish=/usr/bin/wish" \
		|| myconf="${myconf} --disable-wordview"

	econf ${myconf} || die
	emake LIB_DIR=/usr/share/catdoc || die

}

src_install() {

	emake -j1 mandir=/usr/share/man/man1 install || die
	dodoc ${DOCS}

}
