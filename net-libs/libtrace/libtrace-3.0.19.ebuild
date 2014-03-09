# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libtrace/libtrace-3.0.19.ebuild,v 1.1 2014/03/08 23:33:03 radhermit Exp $

EAPI=5

inherit eutils autotools

DESCRIPTION="A library and tools for trace processing"
HOMEPAGE="http://research.wand.net.nz/software/libtrace.php"
SRC_URI="http://research.wand.net.nz/software/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="bzip2 doc lzo ncurses static-libs zlib"

RDEPEND=">=net-libs/libpcap-0.8
	ncurses? ( sys-libs/ncurses )
	bzip2? ( app-arch/bzip2 )
	zlib? ( sys-libs/zlib )
	lzo? ( dev-libs/lzo )"
DEPEND="${RDEPEND}
	app-doc/doxygen
	sys-devel/flex
	virtual/yacc"

src_prepare() {
	# don't build examples
	sed -i "/^SUBDIRS/s/examples//" Makefile.am || die

	# fix autoreconf with automake-1.13
	sed -i 's/AM_CONFIG_HEADER/AC_CONFIG_HEADERS/' configure.in || die

	eautoreconf
}

src_configure() {
	econf \
		--with-man \
		$(use_enable static-libs static) \
		$(use_with ncurses) \
		$(use_with bzip2) \
		$(use_with zlib) \
		$(use_with lzo)
}

src_install() {
	default
	use doc && dohtml docs/doxygen/html/*
	prune_libtool_files --modules
}
