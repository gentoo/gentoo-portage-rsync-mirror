# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/zeromq/zeromq-3.2.2.ebuild,v 1.1 2013/01/20 09:51:02 qnikst Exp $

EAPI=5

inherit autotools

DESCRIPTION="ZeroMQ is a brokerless kernel"
HOMEPAGE="http://www.zeromq.org/"
SRC_URI="http://download.zeromq.org/${P}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~x86 ~ppc ~ppc64 ~amd64-linux ~x86-linux"
IUSE="pgm test static-libs"

DEPEND="sys-devel/gcc
		pgm? (
		  virtual/pkgconfig
		  =net-libs/openpgm-5.1.118
		)
		sys-apps/util-linux"
RDEPEND=""

src_prepare() {
	einfo "Removing bundled OpenPGM library"
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

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc NEWS README AUTHORS ChangeLog || die "dodoc failed"
	doman doc/*.[1-9] || die "doman failed"

	# remove useless .la files
	find "${D}" -name '*.la' -delete

	# remove useless .a (only for non static compilation)
	use static-libs || find "${D}" -name '*.a' -delete
}
