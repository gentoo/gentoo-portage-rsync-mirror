# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-util/fteqcc/fteqcc-2501.ebuild,v 1.5 2010/01/20 20:09:05 maekke Exp $

EAPI=2
inherit eutils flag-o-matic

DESCRIPTION="QC compiler"
HOMEPAGE="http://fteqw.sourceforge.net/"
SRC_URI="mirror://sourceforge/fteqw/qclibsrc${PV}.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""
RESTRICT="test"

DEPEND="app-arch/unzip"
RDEPEND=""

S=${WORKDIR}

src_prepare() {
	epatch "${FILESDIR}"/${P}-cleanup-source.patch
	sed -i \
		-e '/^CC/d' \
		-e "s: -O3 : :g" \
		-e "s: -s : :g" \
		-e 's/-o fteqcc.bin/$(LDFLAGS) -o fteqcc.bin/' \
		Makefile || die "sed failed"
	edos2unix readme.txt
	append-flags -DQCCONLY
}

src_compile() {
	emake BASE_CFLAGS="${CFLAGS} -Wall" || die "emake qcc failed"
}

src_install() {
	newbin fteqcc.bin fteqcc || die "newbin fteqcc.bin failed"
	dodoc readme.txt
}
