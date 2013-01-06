# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libtrace/libtrace-3.0.16.ebuild,v 1.1 2013/01/05 07:34:13 radhermit Exp $

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
	sys-devel/flex
	virtual/yacc"

src_prepare() {
	# skip rebuilding docs when doxygen is present
	epatch "${FILESDIR}"/${PN}-3.0.15-no-doxygen.patch

	# don't build examples
	sed -i "/^SUBDIRS/s/examples//" Makefile.am || die

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
