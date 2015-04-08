# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/snappy/snappy-1.1.2.ebuild,v 1.3 2014/09/26 03:58:07 patrick Exp $

EAPI="5"

inherit eutils autotools

DESCRIPTION="A high-speed compression/decompression library by Google"
HOMEPAGE="https://code.google.com/p/snappy/"
# upstream uses google drive which has hash-based URLS
SRC_URI="http://dev.gentoo.org/~radhermit/dist/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux"
IUSE="static-libs"

src_prepare() {
	# Avoid automagic lzo and gzip by not checking for it
	sed -i '/^CHECK_EXT_COMPRESSION_LIB/d' configure.ac || die

	# don't install unwanted files
	sed -i 's/COPYING INSTALL//' Makefile.am || die

	eautoreconf
}

src_configure() {
	econf \
		--docdir="${EPREFIX}"/usr/share/doc/${PF} \
		--without-gflags \
		--disable-gtest \
		$(use_enable static-libs static)
}

src_install() {
	default
	prune_libtool_files
}
