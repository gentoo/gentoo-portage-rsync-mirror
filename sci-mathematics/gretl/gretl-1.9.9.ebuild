# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/gretl/gretl-1.9.9.ebuild,v 1.1 2012/06/10 18:46:33 jlec Exp $

EAPI=4

USE_EINSTALL=true

inherit eutils gnome2 elisp-common toolchain-funcs

DESCRIPTION="Regression, econometrics and time-series library"
HOMEPAGE="http://gretl.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="accessibility emacs gnome gtk nls odbc openmp readline sse2 R static-libs"

RDEPEND="
	dev-libs/glib:2
	dev-libs/gmp
	dev-libs/libxml2:2
	dev-libs/mpfr
	sci-libs/fftw:3.0
	sci-visualization/gnuplot
	virtual/lapack
	virtual/latex-base
	accessibility? ( app-accessibility/flite )
	emacs? ( virtual/emacs )
	gtk? (
			media-libs/gd[png]
			sci-visualization/gnuplot[gd]
			x11-libs/gtk+:3
			x11-libs/gtksourceview:3.0 )
	gnome? (
				media-libs/gd[png]
				sci-visualization/gnuplot[gd]
				gnome-base/libgnomeui
				gnome-base/gconf:2 )
	odbc? ( dev-db/unixODBC )
	R? ( dev-lang/R )
	readline? ( sys-libs/readline )"

DEPEND="${RDEPEND}
	virtual/pkgconfig"

SITEFILE=50${PN}-gentoo.el

pkg_setup() {
	if use openmp && [[ $(tc-getCC)$ == *gcc* ]] && ! tc-has-openmp
	then
		ewarn "You are using gcc and OpenMP is only available with gcc >= 4.2 "
		die "Need an OpenMP capable compiler"
	fi
}

src_configure() {
	econf \
		--disable-rpath \
		--enable-shared \
		--with-mpfr \
		$(use_enable gtk gui) \
		$(use_enable gtk gtk3) \
		$(use_enable nls) \
		$(use_enable openmp) \
		$(use_enable sse2) \
		$(use_enable static-libs static) \
		$(use_with accessibility audio) \
		$(use_with gnome) \
		$(use_with odbc) \
		$(use_with readline) \
		$(use_with R libR) \
		${myconf} \
		LAPACK_LIBS="$(pkg-config --libs lapack)"
}

src_compile() {
	emake
	if use emacs; then
		elisp-compile utils/emacs/gretl.el || die "elisp-compile failed"
	fi
}

src_install() {
	if use gnome; then
		gnome2_src_install gnome_prefix="${ED}"/usr svprefix="${ED}usr"
	else
		einstall svprefix="${ED}usr"
	fi
	if use gtk && ! use gnome; then
		doicon gnome/gretl.png
		make_desktop_entry gretl_x11 gretl
	fi
	if use emacs; then
		elisp-install ${PN} utils/emacs/gretl.{el,elc} \
			|| die "elisp-install failed"
		elisp-site-file-install "${FILESDIR}/${SITEFILE}" \
			|| die "elisp-site-file-install failed"
	fi
	dodoc README README.audio ChangeLog CompatLog
}

pkg_postinst() {
	if use emacs; then
		elisp-site-regen
		elog "To begin using gretl-mode for all \".inp\" files that you edit,"
		elog "add the following line to your \"~/.emacs\" file:"
		elog "  (add-to-list 'auto-mode-alist '(\"\\\\.inp\\\\'\" . gretl-mode))"
	fi
}

pkg_postrm() {
	use emacs && elisp-site-regen
}
