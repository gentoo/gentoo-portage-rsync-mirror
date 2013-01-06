# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/kbd/kbd-1.14.1-r1.ebuild,v 1.5 2008/09/23 07:20:38 corsair Exp $

inherit eutils

DESCRIPTION="Keyboard and console utilities"
HOMEPAGE="http://freshmeat.net/projects/kbd/"
SRC_URI="ftp://ftp.altlinux.org/pub/people/legion/kbd/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ppc ppc64 ~s390 ~sh ~sparc ~x86"
IUSE="nls"

RDEPEND=""
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i 's:install -s:install:' src/Makefile.in

	# fix unimap path issue caused by Debian patch
	epatch "${FILESDIR}"/${PN}-1.12-unimap.patch

	# Provide a QWERTZ and QWERTY cz map #19010
	cp data/keymaps/i386/{qwertz,qwerty}/cz.map || die "cz qwerty"
	epatch "${FILESDIR}"/${PN}-1.12-cz-qwerty-map.patch

	# Fix jp map to recognize Ctrl-[ as Escape #71870
	epatch "${FILESDIR}"/${PN}-1.12-jp-escape.patch

	epatch "${FILESDIR}"/${P}-missing-configure.patch #215610
	epatch "${FILESDIR}"/${PN}-1.12-kbio.patch
}

src_compile() {
	econf $(use_enable nls) || die
	emake || die
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc CHANGES CREDITS README
	dohtml doc/*.html
}
