# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-auth/libnss-cache/libnss-cache-0.1-r1.ebuild,v 1.1 2010/09/15 00:53:42 xmw Exp $

EAPI=2

inherit eutils multilib toolchain-funcs

DESCRIPTION="libnss-cache is a library that serves nss lookups."
HOMEPAGE="http://code.google.com/p/nsscache/"
SRC_URI="http://nsscache.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

S=${WORKDIR}/${PN}

src_prepare() {
	epatch "${FILESDIR}"/${PF}-make-install.patch
}

src_compile() {
	emake CC="$(tc-getCC)" || die
}

src_install() {
	emake DESTDIR="${D}" LIBDIR="/usr/$(get_libdir)" install || die
}
