# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/mupdf/mupdf-9999.ebuild,v 1.30 2013/06/08 11:31:51 xmw Exp $

EAPI=5

inherit eutils git-2 flag-o-matic multilib toolchain-funcs

DESCRIPTION="a lightweight PDF viewer and toolkit written in portable C"
HOMEPAGE="http://mupdf.com/"
EGIT_REPO_URI="git://git.ghostscript.com/mupdf.git"
#EGIT_HAS_SUBMODULES=1

LICENSE="AGPL-3"
SLOT="0/1.2"
KEYWORDS=""
IUSE="X vanilla static static-libs"

LIB_DEPEND="dev-libs/openssl[static-libs?]
	media-libs/freetype:2[static-libs?]
	media-libs/jbig2dec[static-libs?]
	>=media-libs/openjpeg-1.5:0[static-libs?]
	virtual/jpeg[static-libs?]
	X? ( x11-libs/libX11[static-libs?]
		x11-libs/libXext[static-libs?] )"
RDEPEND="${LIB_DEPEND}"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	static-libs? ( ${LIB_DEPEND} )
	static? ( ${LIB_DEPEND//?}
		app-arch/bzip2[static-libs]
		x11-libs/libXau[static-libs]
		x11-libs/libXdmcp[static-libs]
		x11-libs/libxcb[static-libs] )"

src_prepare() {
	rm -rf thirdparty || die

	epatch \
		"${FILESDIR}"/${P}-buildsystem.patch \
		"${FILESDIR}"/${P}-openjpeg2.patch

	use vanilla || epatch \
		"${FILESDIR}"/${PN}-1.1_rc1-zoom-2.patch

	#http://bugs.ghostscript.com/show_bug.cgi?id=693467
	sed -e '/^Actions=/s:=.*:=View;:' \
		-i debian/${PN}.desktop || die

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
		#add missing Libs.private for xcb and freetype
		sed -e 's:\(pkg-config --libs\):\1 --static:' \
		    -e '/^SYS_X11_LIBS = /s:\(.*\):\1 -lpthread:' \
		    -e '/^SYS_FREETYPE_LIBS = /s:\(.*\):\1 -lbz2:' \
			-i "${S}"-static/Makerules || die
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
		emake -C "${S}"-static XLIBS="-static"
}

src_install() {
	if use X ; then
		domenu debian/mupdf.desktop
		doicon debian/mupdf.xpm
	else
		rm apps/man/mupdf.1
	fi

	emake install
	dosym ${my_soname} /usr/$(get_libdir)/libfitz.so

	use static-libs && \
		dolib.a "${S}"-static/build/debug/libfitz.a
	if use static ; then
		dobin "${S}"-static/build/debug/mu{tool,draw}
		use X && dobin "${S}"-static/build/debug/mupdf
	fi

	insinto /usr/include
	doins pdf/mupdf-internal.h fitz/fitz-internal.h xps/muxps-internal.h

	insinto /usr/$(get_libdir)/pkgconfig
	doins debian/mupdf.pc

	dodoc README doc/{example.c,overview.txt}
}
