# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/zathura-pdf-mupdf/zathura-pdf-mupdf-0.2.3.ebuild,v 1.1 2013/06/08 23:21:25 xmw Exp $

EAPI=5

inherit eutils toolchain-funcs

DESCRIPTION="PDF plug-in for zathura"
HOMEPAGE="http://pwmt.org/projects/zathura/"
SRC_URI="http://pwmt.org/projects/zathura/plugins/download/${P}.tar.gz"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="cairo"

RDEPEND="!app-text/zathura-pdf-poppler
	>=app-text/mupdf-1.2:=
	<app-text/mupdf-9999
	>=app-text/zathura-0.2.0
	media-libs/jbig2dec
	media-libs/openjpeg:0
	virtual/jpeg
	cairo? ( x11-libs/cairo )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

pkg_setup() {
	myzathuraconf=(
		WITH_CAIRO=$(usex cairo 1 0)
		CC="$(tc-getCC)"
		LD="$(tc-getLD)"
		VERBOSE=1
		DESTDIR="${D}"
	)
}

src_compile() {
	emake "${myzathuraconf[@]}"
}

src_install() {
	emake "${myzathuraconf[@]}" install
	dodoc AUTHORS
}
