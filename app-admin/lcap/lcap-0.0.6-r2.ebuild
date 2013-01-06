# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/lcap/lcap-0.0.6-r2.ebuild,v 1.4 2007/12/22 09:55:55 dertobi123 Exp $

inherit eutils toolchain-funcs

PATCH_LEVEL=3.1

DESCRIPTION="kernel capability remover"
HOMEPAGE="http://packages.qa.debian.org/l/lcap.html"
SRC_URI="mirror://debian/pool/main/l/${PN}/${P/-/_}.orig.tar.gz
	mirror://debian/pool/main/l/${PN}/${P/-/_}-${PATCH_LEVEL}.diff.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="lids"

RDEPEND="virtual/libc"
DEPEND="${RDEPEND}
	virtual/os-headers"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${WORKDIR}"/${P/-/_}-${PATCH_LEVEL}.diff
	use lids || sed -i -e "s:LIDS =:#\0:" Makefile
	sed -i -e "s:-O3:${CFLAGS}:" Makefile
}

src_compile() {
	emake CC="$(tc-getCC)" LDFLAGS="${LDFLAGS}" || die "emake failed."
}

src_install() {
	dosbin lcap
	doman lcap.8
	dodoc README debian/changelog
}
