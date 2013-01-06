# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/mecab-naist-jdic/mecab-naist-jdic-0.6.3b_p20111013.ebuild,v 1.1 2012/01/21 02:55:44 matsuu Exp $

EAPI=4

MY_P="${P/_p/-}"
DESCRIPTION="NAIST Japanese Dictionary"
HOMEPAGE="http://sourceforge.jp/projects/naist-jdic/"
SRC_URI="mirror://sourceforge.jp/naist-jdic/53500/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="unicode"

DEPEND="app-text/mecab[unicode=]"
RDEPEND=""

S="${WORKDIR}/${MY_P}"

DOCS="AUTHORS ChangeLog NEWS README"

src_configure() {
	local myconf
	use unicode && myconf="${myconf} --with-charset=utf-8"
	econf ${myconf}
}
