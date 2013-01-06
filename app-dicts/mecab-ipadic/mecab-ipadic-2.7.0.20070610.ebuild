# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/mecab-ipadic/mecab-ipadic-2.7.0.20070610.ebuild,v 1.8 2009/12/27 17:17:04 armin76 Exp $

IUSE="unicode"

MY_P="${PN}-${PV%.*}-${PV/*.}"

DESCRIPTION="IPA dictionary for MeCab"
HOMEPAGE="http://mecab.sourceforge.net/"
SRC_URI="mirror://sourceforge/mecab/${MY_P}.tar.gz"

LICENSE="ipadic"
KEYWORDS="amd64 ~arm ia64 ppc ppc64 sparc x86"
SLOT="0"
S="${WORKDIR}/${MY_P}"

DEPEND=">=app-text/mecab-0.90"

src_compile() {

	local myconf

	use unicode && myconf="${myconf} --with-charset=utf8"

	econf ${myconf} || die
	emake || die

}

src_install() {

	emake DESTDIR="${D}" install || die

}
