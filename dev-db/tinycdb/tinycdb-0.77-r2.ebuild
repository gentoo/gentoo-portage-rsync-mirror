# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/tinycdb/tinycdb-0.77-r2.ebuild,v 1.7 2012/10/08 12:51:28 hattya Exp $

EAPI="4"

inherit eutils multilib toolchain-funcs

DESCRIPTION="TinyCDB is a very fast and simple package for creating and reading constant data bases"
HOMEPAGE="http://www.corpit.ru/mjt/tinycdb.html"
SRC_URI="http://www.corpit.ru/mjt/${PN}/${P/-/_}.tar.gz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="amd64 hppa ia64 ppc x86"
IUSE="static-libs"
RESTRICT="test"

RDEPEND="!dev-db/cdb"

src_prepare() {
	epatch "${FILESDIR}"/${P}-gentoo.diff
	epatch "${FILESDIR}"/${P}-umask.diff
	epatch "${FILESDIR}"/${P}-uclibc.diff
	# fix multilib support
	sed -i "/^libdir/s:/lib:/$(get_libdir):" Makefile
}

src_compile() {
	local targets="shared"
	use static-libs && targets="${targets} staticlib piclib"

	emake CC="$(tc-getCC)" CFLAGS="${CFLAGS} ${LDFLAGS}" ${targets}
}

src_install() {
	local targets="install-sharedlib"
	use static-libs && targets="${targets} install-piclib"

	einstall ${targets}
	dodoc ChangeLog NEWS
}
