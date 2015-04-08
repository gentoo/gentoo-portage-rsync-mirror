# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libmicrohttpd/libmicrohttpd-0.9.37.ebuild,v 1.8 2014/11/02 08:55:54 ago Exp $

EAPI="5"

MY_P="${P/_/}"

DESCRIPTION="A small C library that makes it easy to run an HTTP server as part of another application"
HOMEPAGE="http://www.gnu.org/software/libmicrohttpd/"
SRC_URI="mirror://gnu/${PN}/${MY_P}.tar.gz"

IUSE="epoll messages ssl static-libs test"
KEYWORDS="alpha amd64 arm ~hppa ia64 ~mips ppc ppc64 sparc x86"
LICENSE="LGPL-2.1"
SLOT="0"

RDEPEND="ssl? (
		dev-libs/libgcrypt:0
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
		--enable-bauth \
		--enable-dauth \
		--disable-spdy \
		$(use_enable epoll) \
		$(use_enable test curl) \
		$(use_enable messages) \
		$(use_enable messages postprocessor) \
		$(use_enable ssl https) \
		$(use_with ssl gnutls) \
		$(use_enable static-libs static)
}

src_install() {
	default

	use static-libs || find "${ED}" -name '*.la' -exec rm -f {} +
}
