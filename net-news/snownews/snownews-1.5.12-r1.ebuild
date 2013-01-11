# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-news/snownews/snownews-1.5.12-r1.ebuild,v 1.8 2013/01/11 02:06:25 mr_bones_ Exp $

EAPI=3
inherit eutils toolchain-funcs

DESCRIPTION="Snownews, a text-mode RSS/RDF newsreader"
HOMEPAGE="http://snownews.kcore.de/"
SRC_URI="http://home.kcore.de/~kiza/software/snownews/download/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="amd64 ppc x86 ~amd64-linux ~x86-linux ~x86-macos"
IUSE="unicode"

DEPEND=">=dev-libs/libxml2-2.5.6
	>=sys-libs/ncurses-5.3[unicode?]
	dev-libs/openssl"

RDEPEND="${DEPEND}
	dev-perl/XML-LibXML
	dev-perl/libwww-perl"

src_prepare() {
	use unicode && sed -i -e "s/-lncurses/-lncursesw/" \
		configure

	sed -i -e "s/-O2//" \
		configure

	sed -i -e 's/$(INSTALL) -s/$(INSTALL)/' \
		Makefile
}

src_configure() {
	local conf="--prefix=${EPREFIX}/usr"
	./configure ${conf} || die "configure failed"
}

src_compile() {
	emake CC="$(tc-getCC)" EXTRA_CFLAGS="${CFLAGS}" EXTRA_LDFLAGS="${LDFLAGS}" || die "emake failed"
}

src_install() {
	emake PREFIX="${ED}/usr" install || die "make install failed"

	dodoc AUTHOR Changelog CREDITS README README.de README.patching
}
