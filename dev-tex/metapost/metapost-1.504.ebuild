# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tex/metapost/metapost-1.504.ebuild,v 1.3 2015/03/31 19:23:56 ulm Exp $

EAPI=3

inherit eutils

MY_P=${PN}-beta-${PV}
DESCRIPTION="System for producing graphics"
HOMEPAGE="http://tug.org/metapost.html"
SRC_URI="http://foundry.supelec.fr/gf/download/frsrelease/390/1724/${MY_P}-src.tar.bz2"

LICENSE="GPL-2 LGPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="dev-libs/kpathsea
	>=app-eselect/eselect-mpost-0.3"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${MY_P}/source/texk/web2c

src_prepare() {
	epatch "${FILESDIR}/invocname.patch"
}

src_configure() {
	econf \
		--enable-cxx-runtime-hack \
		--disable-afm2pl    \
		--disable-aleph  \
		--disable-bibtex   \
		--disable-bibtex8   \
		--disable-cfftot1 \
		--disable-cjkutils  \
		--disable-detex    \
		--disable-devnag   \
		--disable-dialog   \
		--disable-dtl      \
		--enable-dump-share  \
		--disable-dvi2tty  \
		--disable-dvidvi   \
		--disable-dviljk   \
		--disable-dvipdfm  \
		--disable-dvipdfmx \
		--disable-dvipos  \
		--disable-dvipsk  \
		--disable-gsftopk \
		--disable-lacheck \
		--disable-luatex \
		--disable-lcdf-typetools \
		--disable-makeindexk \
		--disable-mf  \
		--disable-mmafm \
		--disable-mmpfb \
		--enable-mp  \
		--disable-musixflx \
		--disable-otfinfo \
		--disable-otftotfm  \
		--disable-pdfopen  \
		--disable-pdftex  \
		--disable-ps2eps   \
		--disable-ps2pkm \
		--disable-psutils  \
		--disable-seetexk \
		--disable-t1dotlessj  \
		--disable-t1lint \
		--disable-t1rawafm \
		--disable-t1reencode \
		--disable-t1testpage \
		--disable-t1utils  \
		--disable-tex    \
		--disable-tex4htk \
		--disable-tpic2pdftex  \
		--disable-ttf2pk \
		--disable-ttfdump \
		--disable-ttftotype42 \
		--disable-vlna  \
		--disable-web-progs \
		--disable-xdv2pdf \
		--disable-xdvipdfmx \
		--disable-xetex \
		--with-system-kpathsea \
		--with-system-freetype2 \
		--with-system-gd \
		--with-system-libpng \
		--with-system-teckit \
		--with-system-zlib \
		--with-system-t1lib \
		--disable-shared    \
		--disable-largefile \
		--disable-native-texlive-build \
		--without-mf-x-toolkit --without-x
}

src_compile() {
	emake mpost || die
}

src_install() {
	emake DESTDIR="${D}" \
		SUBDIRS="" \
		bin_PROGRAMS="mpost" \
		nodist_man_MANS="" \
		dist_man_MANS="" \
		install-binPROGRAMS	|| die
	# Rename it
	mv "${D}/usr/bin/mpost" "${D}/usr/bin/mpost-${P}" || die "renaming failed"

	cd "${WORKDIR}/${MY_P}"
	dodoc README CHANGES || die
}

pkg_postinst(){
	einfo "Calling eselect mpost update"
	eselect mpost update
}
