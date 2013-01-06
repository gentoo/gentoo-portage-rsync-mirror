# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/lv/lv-4.51-r1.ebuild,v 1.8 2010/08/25 18:16:10 maekke Exp $

inherit eutils toolchain-funcs

MY_P="${PN}${PV//./}"
DESCRIPTION="Powerful Multilingual File Viewer"
HOMEPAGE="http://www.ff.iij4u.or.jp/~nrt/lv/"
SRC_URI="http://www.ff.iij4u.or.jp/~nrt/freeware/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ~arm ia64 ppc ppc64 sh sparc x86 ~x86-fbsd"
IUSE=""

RDEPEND="sys-libs/ncurses
	!app-editors/levee"
DEPEND="${RDEPEND}
	dev-lang/perl"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-gentoo.patch
}

src_compile() {
	ECONF_SOURCE=src econf || die
	emake CC="$(tc-getCC)" || die
}

src_install() {
	emake DESTDIR="${D}" install || die

	dodoc README hello.sample
	dohtml index.html relnote.html hello.sample.gif
}
