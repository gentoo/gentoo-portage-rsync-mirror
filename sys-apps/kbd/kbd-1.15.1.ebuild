# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/kbd/kbd-1.15.1.ebuild,v 1.2 2009/10/18 18:03:09 vapier Exp $

inherit autotools

DESCRIPTION="Keyboard and console utilities"
HOMEPAGE="http://freshmeat.net/projects/kbd/"
SRC_URI="ftp://ftp.altlinux.org/pub/people/legion/kbd/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE="nls"

RDEPEND=""
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	eautoreconf # stupid tarball lacks generated autotools
	sed -i 's:-Werror::' src/Makefile.in
}

src_compile() {
	econf $(use_enable nls) || die
	emake || die
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog INSTALL NEWS README
	dohtml doc/*.html
}
