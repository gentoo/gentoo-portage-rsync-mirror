# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/mupdf/mupdf-1.2.ebuild,v 1.4 2013/06/07 22:52:15 xmw Exp $

EAPI=5

inherit eutils flag-o-matic multilib toolchain-funcs

DESCRIPTION="a lightweight PDF viewer and toolkit written in portable C"
HOMEPAGE="http://mupdf.com/"
SRC_URI="http://${PN}.googlecode.com/files/${P}-source.zip"

LICENSE="AGPL-3"
SLOT="0/1.2"
KEYWORDS="~amd64 ~ppc ~x86 ~amd64-linux ~ppc-macos ~x64-macos ~x86-macos"
IUSE="X vanilla static static-libs"

RDEPEND="media-libs/freetype:2
	media-libs/jbig2dec
	>=media-libs/openjpeg-1.5:0
	virtual/jpeg
	X? ( x11-libs/libX11
		x11-libs/libXext )"
DEPEND="${RDEPEND}
	static? ( app-arch/bzip2[static-libs]
		media-libs/freetype:2[static-libs]
		media-libs/jbig2dec[static-libs]
		virtual/jpeg[static-libs]
		X? ( x11-libs/libX11[static-libs]
			x11-libs/libXext[static-libs] )	)
	virtual/pkgconfig"

S=${WORKDIR}/${P}-source

src_prepare() {
	rm -rf thirdparty || die

	epatch \
		"${FILESDIR}"/${PN}-1.1_p20121127-buildsystem.patch \
		"${FILESDIR}"/${PN}-1.1_p20121127-desktop-integration.patch \
		"${FILESDIR}"/${PN}-1.2-mubusy_rename_fix.patch

	use vanilla || epatch \
		"${FILESDIR}"/${PN}-1.1_rc1-zoom-2.patch

	sed -e "\$aOS = Linux" \
		-e "\$aCC = $(tc-getCC)" \
		-e "\$aLD = $(tc-getCC)" \
		-e "\$aAR = $(tc-getAR)" \
		-e "\$averbose = true" \
		-e "\$abuild = debug" \
		-e "\$aprefix = ${ED}usr" \
		-e "\$alibdir = ${ED}usr/$(get_libdir)" \
		-i Makerules || die
	
	if ! use X ; then
		sed -e "\$aNOX11 = yes" \
			-i Makerules || die
	fi

	if use static-libs || use static ; then
		cp -a "${S}" "${S}"-static || die
		sed -e '/^LIBS +=/s: -lopenjpeg : :' \
			-e '/^LIBS +=/s:=\(.*\):= -Wl,-Bstatic \1 -lbz2 -Wl,-Bdynamic -lopenjpeg:' \
			-i "${S}"-static/Makefile
	fi

	my_soname=libfitz.so.1.2
	sed -e "\$a\$(FITZ_LIB):" \
		-e "\$a\\\t\$(QUIET_LINK) \$(CC) \$(LDFLAGS) --shared -Wl,-soname -Wl,${my_soname} -o \$@ \$^" \
		-e "/^FITZ_LIB :=/s:=.*:= build/debug/${my_soname}:" \
		-i Makefile || die
}

src_compile() {
	emake XCFLAGS="-fpic"
	use static-libs && \
		emake -C "${S}"-static build/debug/libfitz.a
	use static && \
		emake -C "${S}"-static
}

src_install() {
	if use X ; then
		domenu debian/mupdf.desktop
		doicon debian/mupdf.xpm
		use static && dobin "${S}"-static/build/debug/mupdf
	else
		rm apps/man/mupdf.1
	fi

	emake install
	dosym ${my_soname} /usr/$(get_libdir)/libfitz.so
	
	use static-libs && \
		dolib.a "${S}"-static/build/debug/libfitz.a
	use static && \
		dobin "${S}"-static/build/debug/mu{tool,draw}
	
	insinto /usr/include
	doins pdf/mupdf-internal.h fitz/fitz-internal.h xps/muxps-internal.h
		
	insinto /usr/$(get_libdir)/pkgconfig
	doins debian/mupdf.pc

	dodoc CHANGES README doc/{example.c,overview.txt}
}
