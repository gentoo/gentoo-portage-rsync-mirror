# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/aalib/aalib-1.4_rc5-r5.ebuild,v 1.1 2013/05/05 14:42:47 slyfox Exp $

EAPI=4

inherit autotools eutils toolchain-funcs

MY_P="${P/_/}"
S="${WORKDIR}/${PN}-1.4.0"

DESCRIPTION="A ASCII-Graphics Library"
HOMEPAGE="http://aa-project.sourceforge.net/aalib/"
SRC_URI="mirror://sourceforge/aa-project/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~amd64-fbsd ~x86-fbsd"
IUSE="X slang gpm static-libs"

RDEPEND="X? ( x11-libs/libX11 )
	gpm? ( sys-libs/gpm )
	slang? ( >=sys-libs/slang-1.4.2 )
	>=sys-libs/ncurses-5.1
"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	X? ( x11-proto/xproto )
"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-1.4_rc4-gentoo.patch
	epatch "${FILESDIR}"/${PN}-1.4_rc4-m4.patch
	epatch "${FILESDIR}"/${PN}-1.4_rc5-fix-protos.patch #224267
	epatch "${FILESDIR}"/${PN}-1.4_rc5-fix-aarender.patch #214142
	epatch "${FILESDIR}"/${PN}-1.4_rc5-tinfo.patch #468566

	sed -i -e 's:#include <malloc.h>:#include <stdlib.h>:g' "${S}"/src/*.c

	# Fix bug #165617.
	use gpm || sed -i \
		's/gpm_mousedriver_test=yes/gpm_mousedriver_test=no/' "${S}/configure.in"

	#467988 automake-1.13
	mv configure.{in,ac} || die
	sed -i 's/AM_CONFIG_HEADER/AC_CONFIG_HEADERS/g' configure.ac || die
	eautoreconf
}

src_configure() {
	PKG_CONFIG=$(tc-getPKG_CONFIG) \
	econf \
		$(use_with slang slang-driver) \
		$(use_with X x11-driver) \
		$(use_enable static-libs static)
}

src_install() {
	default
	dodoc ANNOUNCE AUTHORS ChangeLog NEWS README*
	use static-libs || find "${ED}" -name '*.la' -delete
}
