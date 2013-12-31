# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/zeromq/zeromq-4.0.1.ebuild,v 1.3 2013/12/24 11:14:32 jlec Exp $

EAPI=5

inherit autotools

DESCRIPTION="ZeroMQ is a brokerless kernel"
HOMEPAGE="http://www.zeromq.org/"
SRC_URI="http://download.zeromq.org/${P}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm ~hppa ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux"
IUSE="pgm test static-libs elibc_glibc"

DEPEND="
	pgm? (
		virtual/pkgconfig
		=net-libs/openpgm-5.1.118
		)
	sys-apps/util-linux"
RDEPEND=""

src_prepare() {
	einfo "Removing bundled OpenPGM library"
#	sed -i 's/AM_CONFIG_HEADER/AC_CONFIG_HEADERS/g' configure.in || die
	rm -r "${S}"/foreign/openpgm/libpgm* || die
	eautoreconf
}

src_configure() {
	local myconf
	use pgm && myconf="--with-system-pgm" || myconf="--without-pgm"
	econf \
		$(use_enable static-libs static) \
		$myconf
}

src_test() {
	emake -j1 check
}

src_install() {
	emake DESTDIR="${D}" install
	dodoc NEWS AUTHORS ChangeLog
	doman doc/*.[1-9]

	# remove useless .la files
	find "${D}" -name '*.la' -delete || die

	# remove useless .a (only for non static compilation)
	if use static-libs; then
		find "${D}" -name '*.a' -delete || die
	fi
}

src_test() {
	emake -j1 check
}
