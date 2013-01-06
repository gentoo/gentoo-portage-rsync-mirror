# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/libgeotiff/libgeotiff-1.2.4.ebuild,v 1.13 2012/07/29 16:58:17 armin76 Exp $

inherit autotools eutils flag-o-matic

DESCRIPTION="Library for reading TIFF files with embedded tags for geographic (cartographic) information"
HOMEPAGE="http://www.remotesensing.org/geotiff/geotiff.html"
SRC_URI="ftp://ftp.remotesensing.org/pub/geotiff/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~mips ppc ppc64 x86"
IUSE="doc python"

RDEPEND=">=media-libs/tiff-3.7
	virtual/jpeg
	sci-libs/proj"

DEPEND="${RDEPEND}
	doc? ( app-doc/doxygen )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-soname.patch
	append-ldflags -Wl,-O0
	eautoconf
}

src_compile() {
	econf
	emake -j1 || die "emake failed"

	if use doc; then
	    emake dox || die "emake dox failed"
	fi
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	dobin bin/makegeo || die "dobin makegeo failed"

	if use python; then
		dobin csv/*.py || die "dobin python failed"
	fi

	dodoc README
	newdoc csv/README README.csv
	use doc && dohtml docs/api/*
}
