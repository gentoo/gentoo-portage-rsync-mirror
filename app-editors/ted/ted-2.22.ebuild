# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/ted/ted-2.22.ebuild,v 1.8 2013/04/01 09:21:22 pinkbyte Exp $

EAPI=4
inherit eutils toolchain-funcs

DESCRIPTION="X-based rich text editor"
HOMEPAGE="http://www.nllgg.nl/Ted"
SRC_URI="ftp://ftp.nluug.nl/pub/editors/ted/${P}.src.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc sparc x86"
IUSE=""

RDEPEND="x11-libs/gtk+:2
	media-libs/tiff
	virtual/jpeg
	media-libs/libpng
	x11-libs/libXft
	x11-libs/libXpm"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

S=${WORKDIR}/Ted-${PV}

src_prepare() {
	epatch "${FILESDIR}"/${PN}-2.21-make.patch

	sed -i -e 's|/Ted/|/share/Ted/|' \
		"${S}"/appFrame/appFrameConfig.h.in \
		"${S}"/Ted/tedConfig.h.in || die

	# bug #461256
	find . -name makefile.in -exec sed -i -e '/ar r/s/ar/$(AR)/' {} \; || die

	mkdir lib || die
}

src_configure() {
	tc-export AR CC RANLIB

	local dir
	for dir in appFrame appUtil bitmap docBuf ind Ted tedPackage; do
		cd "${S}"/${dir}
		econf --cache-file=../config.cache || die "configure in ${dir} failed"
	done
}

src_compile() {
	emake package.shared
}

src_install() {
	cd tedPackage
	RPM_BUILD_ROOT=${D} ./installTed.sh COMMON || die

	dodir /usr/share
	mv "${ED}"usr/Ted "${ED}"usr/share/Ted
	dosym /usr/share/Ted/rtf2pdf.sh /usr/bin/rtf2pdf.sh

	# bug #461252, desktop file is inaccessible during src_prepare, so fix it here
	sed -i \
		-e '/^Encoding/d' \
		-e '/^Categories/s/Application;//' \
		-e 's/^Categories.*/\0;/' \
		-e 's/^MimeType.*/\0;/' \
		-e '/^Terminal/s/0/false/' \
		"${D}/usr/share/applications/Ted.desktop" || die 'sed on Ted.desktop failed'
}
