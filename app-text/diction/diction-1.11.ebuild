# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/diction/diction-1.11.ebuild,v 1.13 2010/11/04 20:07:53 jer Exp $

DESCRIPTION="Diction and style checkers for english and german texts"
HOMEPAGE="http://www.gnu.org/software/diction/diction.html"
SRC_URI="http://www.moria.de/~michael/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 hppa ~mips ppc sparc x86 ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos"
IUSE="unicode"

DEPEND="sys-devel/gettext
	virtual/libintl"
RDEPEND=""

src_unpack() {
	unpack ${A}
	cd "${S}"
	if use unicode; then
		for lang in de nl; do
			iconv -f ISO-8859-1 -t UTF-8 ${lang} > ${lang}.new || die "iconv failed."
			mv ${lang}.new ${lang}
		done
	fi
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc NEWS README
}
