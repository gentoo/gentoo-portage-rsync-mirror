# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/ustr/ustr-1.0.4-r2.ebuild,v 1.1 2013/10/13 13:40:41 jer Exp $

EAPI=5

inherit multilib toolchain-funcs

DESCRIPTION="Low-overhead managed string library for C"
HOMEPAGE="http://www.and.org/ustr"
SRC_URI="ftp://ftp.and.org/pub/james/ustr/${PV}/${P}.tar.bz2"

LICENSE="|| ( BSD-2 MIT LGPL-2 )"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

src_compile() {
	emake AR=$(tc-getAR) CC=$(tc-getCC) CFLAGS="${CFLAGS}" HIDE= all-shared
}

src_test() {
	emake AR=$(tc-getAR) CC=$(tc-getCC) CFLAGS="${CFLAGS}" HIDE= check
}

src_install() {
	emake install DESTDIR="${D}" HIDE= \
		libdir="/usr/$(get_libdir)" \
		mandir="/usr/share/man" \
		SHRDIR="/usr/share/doc/${PF}" \
		DOCSHRDIR="/usr/share/doc/${PF}"

	dodoc ChangeLog README README-DEVELOPERS AUTHORS NEWS TODO
}
