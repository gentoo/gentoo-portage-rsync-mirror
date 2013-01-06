# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-util/loki_patch/loki_patch-20091105.ebuild,v 1.4 2012/05/03 03:41:15 jdhore Exp $

EAPI=2
inherit autotools eutils

DESCRIPTION="Loki Software binary patch tool"
HOMEPAGE="http://www.icculus.org/loki_setup/"
SRC_URI="mirror://gentoo/${P}.tar.bz2
	mirror://gentoo/loki_setupdb-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE=""

RDEPEND="dev-util/xdelta:0
	dev-libs/libxml2
	dev-libs/glib:2"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

S=${WORKDIR}

src_prepare() {
	epatch \
		"${FILESDIR}"/${P}-build.patch \
		"${FILESDIR}"/${P}-patchdata.patch
	cd loki_setupdb
	eautoreconf
	cd "${S}"/${PN}
	eautoreconf
}

src_configure() {
	cd loki_setupdb
	econf
	cd "${S}"/${PN}
	econf
}

src_compile() {
	emake -C loki_setupdb || die "emake loki_setupdb failed"
	emake -C loki_patch || die "emake loki_patch failed"
}

src_install() {
	cd ${PN}
	dobin loki_patch make_patch || die "dobin failed"
	dodoc CHANGES NOTES README TODO
}
