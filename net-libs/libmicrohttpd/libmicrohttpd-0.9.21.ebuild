# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libmicrohttpd/libmicrohttpd-0.9.21.ebuild,v 1.3 2012/10/17 03:28:12 phajdan.jr Exp $

EAPI="4"

MY_P="${P/_/}"

DESCRIPTION="A small C library that makes it easy to run an HTTP server as part of another application."
HOMEPAGE="http://www.gnu.org/software/libmicrohttpd/"
SRC_URI="mirror://gnu/${PN}/${MY_P}.tar.gz"

IUSE="messages ssl static-libs test"
KEYWORDS="amd64 x86"
LICENSE="LGPL-2.1"
SLOT="0"

RDEPEND="ssl? (
		dev-libs/libgcrypt
		net-libs/gnutls
	)"

DEPEND="${RDEPEND}
	test?	(
		ssl? ( >=net-misc/curl-7.25.0-r1[ssl] )
	)"

S=${WORKDIR}/${MY_P}

DOCS="AUTHORS NEWS README ChangeLog"

src_configure() {
	econf \
		$(use_enable test curl) \
		$(use_enable messages) \
		$(use_enable ssl https) \
		$(use_with ssl gnutls) \
		$(use_enable static-libs static)
}

src_install() {
	default

	use static-libs || find "${ED}" -name '*.la' -exec rm -f {} +
}
