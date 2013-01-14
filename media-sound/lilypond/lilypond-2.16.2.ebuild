# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/lilypond/lilypond-2.16.2.ebuild,v 1.1 2013/01/14 03:04:10 radhermit Exp $

EAPI="5"
PYTHON_COMPAT=( python{2_5,2_6,2_7} )

inherit elisp-common autotools eutils python-single-r1

DESCRIPTION="GNU Music Typesetter"
SRC_URI="http://download.linuxaudio.org/lilypond/sources/v${PV:0:4}/${P}.tar.gz"
HOMEPAGE="http://lilypond.org/"

SLOT="0"
LICENSE="GPL-3 FDL-1.3"
KEYWORDS="~amd64 ~hppa ~x86"
LANGS=" cs da de el eo es fi fr it ja nl ru sv tr uk vi zh_TW"
IUSE="debug emacs profile vim-syntax ${LANGS// / linguas_}"

RDEPEND=">=app-text/ghostscript-gpl-8.15
	>=dev-scheme/guile-1.8.2[deprecated,regex]
	media-fonts/urw-fonts
	media-libs/fontconfig
	media-libs/freetype:2
	>=x11-libs/pango-1.12.3
	emacs? ( virtual/emacs )
	${PYTHON_DEPS}"
DEPEND="${RDEPEND}
	app-text/t1utils
	dev-lang/perl
	dev-texlive/texlive-metapost
	virtual/pkgconfig
	media-gfx/fontforge
	>=sys-apps/texinfo-4.11
	>=sys-devel/bison-2.0
	sys-devel/flex
	sys-devel/gettext
	sys-devel/make"

# Correct output data for tests isn't bundled with releases
RESTRICT="test"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-2.16.0-tex-docs.patch

	if ! use vim-syntax ; then
		sed -i -e "s/vim//" GNUmakefile.in || die
	fi

	sed -i -e "s/OPTIMIZE -g/OPTIMIZE/" aclocal.m4 || die

	for lang in ${LANGS}; do
		use linguas_${lang} || rm po/${lang}.po || die
	done

	eautoreconf
}

src_configure() {
	# documentation generation currently not supported since it requires a newer
	# version of texi2html than is currently in the tree

	econf \
		--with-ncsb-dir=/usr/share/fonts/urw-fonts \
		--disable-documentation \
		--disable-optimising \
		--disable-pipe \
		$(use_enable debug debugging) \
		$(use_enable profile profiling)
}

src_compile() {
	default

	if use emacs ; then
		elisp-compile elisp/lilypond-{font-lock,indent,mode,what-beat}.el \
			|| die "elisp-compile failed"
	fi
}

src_install () {
	emake DESTDIR="${D}" vimdir=/usr/share/vim/vimfiles install

	# remove elisp files since they are in the wrong directory
	rm -r "${ED}"/usr/share/emacs || die

	if use emacs ; then
		elisp-install ${PN} elisp/*.{el,elc} elisp/out/*.el \
			|| die "elisp-install failed"
		elisp-site-file-install "${FILESDIR}"/50${PN}-gentoo.el
	fi

	python_fix_shebang "${ED}"

	dodoc AUTHORS.txt HACKING NEWS.txt README.txt THANKS
}

pkg_postinst() {
	use emacs && elisp-site-regen
}

pkg_postrm() {
	use emacs && elisp-site-regen
}
