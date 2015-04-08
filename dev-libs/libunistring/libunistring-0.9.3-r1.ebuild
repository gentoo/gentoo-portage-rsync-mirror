# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libunistring/libunistring-0.9.3-r1.ebuild,v 1.5 2013/05/08 18:34:28 grobian Exp $

EAPI="3"

inherit eutils

DESCRIPTION="Library for manipulating Unicode strings and C strings according to the Unicode standard"
HOMEPAGE="http://www.gnu.org/software/libunistring/"
SRC_URI="mirror://gnu/${PN}/${P}.tar.gz"

LICENSE="LGPL-3 GPL-3"
SLOT="0"
KEYWORDS="amd64 ~arm x86 ~amd64-linux"
IUSE="doc"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-nodocs.patch
}

src_install() {
	dodoc AUTHORS README ChangeLog || die "dodoc failed"
	if use doc; then
		dohtml doc/*.html || die "dohtml failed"
		doinfo doc/*.info || die "doinfo failed"
	fi

	emake DESTDIR="${D}" install || die "Install failed"
}
