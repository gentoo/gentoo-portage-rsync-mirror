# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tex/pdftex/pdftex-1.40.11.ebuild,v 1.8 2012/11/05 11:02:23 aballier Exp $

EAPI=4
inherit libtool toolchain-funcs eutils

DESCRIPTION="Standalone version of pdftex that can be used to replace TeX Live's"
HOMEPAGE="http://www.pdftex.org/"
SLOT="0"
LICENSE="GPL-2"

SRC_URI="http://sarovar.org/frs/download.php/1300/${P}.tar.bz2"

KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=app-text/poppler-0.12.3-r3[xpdf-headers(+)]
	>=media-libs/libpng-1.4
	sys-libs/zlib
	dev-libs/kpathsea
	app-admin/eselect-pdftex"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

S=${WORKDIR}/${P}/build

src_unpack() {
	unpack ${A}
	mkdir "${S}" || die
}

src_prepare() {
	cd "${WORKDIR}/${P}/src" || die
	epatch "${FILESDIR}/${P}-libpng15.patch"
	elibtoolize
}

src_configure() {
	# Too many regexps use A-Z a-z constructs, what causes problems with locales
	# that don't have the same alphabetical order than ascii. Bug #293199
	# So we set LC_ALL to C in order to avoid problems.
	export LC_ALL=C

	ECONF_SOURCE="${WORKDIR}/${P}/src" econf -C \
		--disable-cxx-runtime-hack	\
		--disable-all-pkgs			\
		--disable-ptex				\
		--enable-pdftex				\
		--disable-native-texlive-build \
		--without-mf-x-toolkit		\
		--without-x					\
		--disable-shared			\
		--disable-largefile			\
		--with-system-xpdf			\
		--with-system-zlib			\
		--with-system-pnglib		\
		--disable-multiplatform		\
		--with-system-kpathsea		\
		--with-system-ptexenc
}

src_compile() {
	emake SHELL=/bin/sh || die
	cd "${S}/texk/web2c" || die
	emake pdftex || die
}

src_install() {
	cd "${S}/texk/web2c" || die
	emake DESTDIR="${D}" \
		SUBDIRS="" \
		bin_PROGRAMS="pdftex" \
		nodist_man_MANS="" \
		dist_man_MANS="" \
		install-binPROGRAMS || die
	# Rename it
	mv "${D}/usr/bin/pdftex" "${D}/usr/bin/pdftex-${P}" || die "renaming failed"
}

pkg_postinst(){
	einfo "Calling eselect pdftex update"
	eselect pdftex update
}
