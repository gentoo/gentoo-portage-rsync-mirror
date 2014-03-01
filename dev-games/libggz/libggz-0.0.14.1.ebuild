# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-games/libggz/libggz-0.0.14.1.ebuild,v 1.17 2014/03/01 22:32:00 mgorny Exp $

EAPI=4

inherit games-ggz

DESCRIPTION="The GGZ library, used by GGZ Gaming Zone"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 sh sparc x86 ~amd64-linux ~x86-linux"
IUSE="debug gnutls static-libs"

DEPEND="dev-libs/libgcrypt:0
	gnutls? ( net-libs/gnutls )
	!gnutls? ( dev-libs/openssl )"
RDEPEND="${DEPEND}"

PATCHES=( "${FILESDIR}"/${P}-gnutls3.patch )

src_configure() {
	games-ggz_src_configure \
		--with-gcrypt \
		--with-tls=$(use gnutls && echo GnuTLS || echo OpenSSL) \
		$(use_enable static-libs static)
}

src_install() {
	games-ggz_src_install
	use static-libs || find "${ED}" -name '*.la' -exec rm -f {} +
}
