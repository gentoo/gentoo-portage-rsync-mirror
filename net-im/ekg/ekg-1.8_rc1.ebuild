# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/ekg/ekg-1.8_rc1.ebuild,v 1.5 2011/03/02 19:54:53 signals Exp $

EAPI=2
inherit autotools eutils

IUSE="gif gtk jpeg ncurses python readline spell ssl threads zlib"

DESCRIPTION="EKG (Eksperymentalny Klient Gadu-Gadu) - a text client for Polish instant messaging system Gadu-Gadu"
HOMEPAGE="http://ekg.chmurka.net/"
SRC_URI="http://ekg.chmurka.net/${P/_/}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~sparc ~x86"

S="${WORKDIR}/${P/_/}"

RDEPEND="net-libs/libgadu
	ssl? ( >=dev-libs/openssl-0.9.6 )
	ncurses? ( sys-libs/ncurses )
	readline? ( sys-libs/readline )
	zlib? ( sys-libs/zlib )
	python? ( dev-lang/python )
	spell? ( >=app-text/aspell-0.50.3 )
	gif? ( media-libs/giflib )
	jpeg? ( virtual/jpeg )
	gtk? ( x11-libs/gtk+:2 )"

DEPEND=">=sys-devel/automake-1.7
	>=sys-devel/autoconf-2.50
	${RDEPEND}"

src_prepare() {
	epatch "${FILESDIR}/${P}-gtkutil-button-decl.patch"
	epatch "${FILESDIR}/${P}-as-needed.patch"
	epatch "${FILESDIR}/${P}-gtk.patch"
	eautoreconf
}

src_configure() {
	local myconf="--enable-ioctld --disable-static --enable-dynamic"
	if use ncurses; then
		myconf="$myconf --enable-force-ncurses"
	else
		myconf="$myconf --disable-ui-ncurses"
	fi
	use readline && myconf="$myconf --enable-ui-readline"

	econf ${myconf} \
		`use_with python` \
		`use_with threads pthread` \
		`use_with jpeg libjpeg` \
		`use_with gif libgif` \
		`use_with zlib` \
		`use_enable spell aspell` \
		`use_with ssl openssl` \
		`use_enable ssl openssl` \
		`use_enable gtk ui-gtk` \
	|| die
}

src_compile() {
	emake || die
}

src_install() {
	make DESTDIR="${D}" install || die
	dodoc docs/{*.txt,ULOTKA,TODO,README,FAQ}
}
