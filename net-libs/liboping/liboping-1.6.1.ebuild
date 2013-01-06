# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/liboping/liboping-1.6.1.ebuild,v 1.4 2011/08/30 22:55:57 dilfridge Exp $

EAPI=4

inherit base autotools

DESCRIPTION="C library and ncurses based program to generate ICMP echo requests and ping multiple hosts at once"
HOMEPAGE="http://verplant.org/liboping"
SRC_URI="http://verplant.org/${PN}/files/${P}.tar.bz2"

LICENSE="LGPL-2.1 GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="perl"

DEPEND="
	sys-libs/ncurses
	perl? ( dev-lang/perl sys-devel/libperl  )
"
RDEPEND=${DEPEND}

PATCHES=( "${FILESDIR}/${P}-nouidmagic.patch" )

src_prepare() {
	base_src_prepare
	eautoreconf
}

src_configure() {
	econf \
		$(use_with perl perl-bindings INSTALLDIRS=vendor) \
		--disable-static
}

src_install() {
	default
	find "${D}" -name '*.la'  -delete || die

	fperms u+s,og-r /usr/bin/oping
	fperms u+s,og-r /usr/bin/noping
}
