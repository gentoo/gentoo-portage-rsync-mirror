# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/zeromq/zeromq-4.0.1-r1.ebuild,v 1.3 2013/12/07 13:34:38 maekke Exp $

EAPI=5

inherit autotools eutils

DESCRIPTION="ZeroMQ is a brokerless kernel"
HOMEPAGE="http://www.zeromq.org/"
SRC_URI="http://download.zeromq.org/${P}.tar.gz"
RESTRICT="mirror"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm ~hppa ~x86 ~amd64-linux ~x86-linux"
IUSE="elibc_glibc pgm static-libs test"

RDEPEND="
	dev-libs/libsodium
	pgm? ( =net-libs/openpgm-5.1.118 )"
DEPEND="${RDEPEND}
	sys-devel/gcc
	pgm? ( virtual/pkgconfig )
	sys-apps/util-linux"

src_prepare() {
	einfo "Removing bundled OpenPGM library"
#	sed -i 's/AM_CONFIG_HEADER/AC_CONFIG_HEADERS/g' configure.in || die
	rm -r "${S}"/foreign/openpgm/libpgm* || die
	sed \
		-e '/libzmq_werror=/s:yes:no:g' \
		-i configure.ac || die
	eautoreconf
}

src_configure() {
	local myconf
	use pgm && myconf="--with-system-pgm" || myconf="--without-pgm"
	econf \
		$(use_enable static-libs static) \
		$myconf
}

src_install() {
	default

	doman doc/*.[1-9]

	prune_libtool_files
}
