# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/lcap/lcap-0.0.6-r2.ebuild,v 1.5 2014/03/10 10:31:31 ssuominen Exp $

EAPI=5
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

DEPEND="virtual/os-headers"

src_prepare() {
	epatch "${WORKDIR}"/${P/-/_}-${PATCH_LEVEL}.diff
	use lids || { sed -i -e "s:LIDS =:#\0:" Makefile || die; }
	sed -i -e "s:-O3:${CFLAGS}:" Makefile || die
}

src_compile() {
	emake CC="$(tc-getCC)" LDFLAGS="${LDFLAGS}"
}

src_install() {
	dosbin lcap
	doman lcap.8
	dodoc README debian/changelog
}
