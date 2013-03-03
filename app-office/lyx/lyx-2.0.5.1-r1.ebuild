# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/lyx/lyx-2.0.5.1-r1.ebuild,v 1.2 2013/03/02 19:36:01 hwoarang Exp $

EAPI=3

PYTHON_DEPEND="2"

inherit gnome2-utils qt4-r2 eutils flag-o-matic font python toolchain-funcs

MY_P="${P/_}"

S="${WORKDIR}/${MY_P}"
FONT_S="${S}/lib/fonts"
FONT_SUFFIX="ttf"
DESCRIPTION="WYSIWYM frontend for LaTeX, DocBook, etc."
HOMEPAGE="http://www.lyx.org/"
SRC_URI="ftp://ftp.lyx.org/pub/lyx/stable/2.0.x/${P}.tar.xz"
#SRC_URI="ftp://ftp.lyx.org/pub/lyx/devel/lyx-2.0/rc3/${MY_P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x64-macos ~x86-macos"
IUSE="cups debug nls +latex monolithic-build html rtf dot docbook dia subversion rcs svg gnumeric +hunspell aspell enchant"

LANGS="ar ca cs de da el en es eu fi fr gl he hu ia id it ja nb nn pl pt ro ru sk sr sv tr uk zh_CN zh_TW"

for X in ${LANGS}; do
	IUSE="${IUSE} linguas_${X}"
done

COMMONDEPEND="dev-qt/qtgui:4
	dev-qt/qtcore:4
	>=dev-libs/boost-1.34"

RDEPEND="${COMMONDEPEND}
	dev-texlive/texlive-fontsextra
	|| ( media-gfx/imagemagick[png] media-gfx/graphicsmagick[png] )
	cups? ( net-print/cups )
	latex? (
		app-text/texlive
		app-text/ghostscript-gpl
		app-text/noweb
		app-text/dvipng
		dev-tex/dvipost
		dev-tex/chktex
		app-text/ps2eps
		dev-texlive/texlive-latexextra
		dev-texlive/texlive-pictures
		dev-texlive/texlive-science
		dev-texlive/texlive-genericextra
		dev-texlive/texlive-fontsrecommended
		|| (
			dev-tex/latex2html
			dev-tex/tth
			dev-tex/hevea
			dev-tex/tex4ht
		)
	)
	html? ( dev-tex/html2latex )
	rtf? (
			dev-tex/latex2rtf
			app-text/unrtf
			dev-tex/html2latex
		)
	linguas_he? ( dev-tex/culmus-latex )
	docbook? ( app-text/sgmltools-lite )
	dot? ( media-gfx/graphviz )
	dia? ( app-office/dia )
	subversion? ( <dev-vcs/subversion-1.7.0 )
	rcs? ( dev-vcs/rcs )
	svg? (  || ( media-gfx/imagemagick[svg] media-gfx/graphicsmagick[svg] )
			|| ( gnome-base/librsvg media-gfx/inkscape )
		)
	gnumeric? ( app-office/gnumeric )
	hunspell? ( app-text/hunspell )
	aspell? ( app-text/aspell )
	enchant? ( app-text/enchant )"

DEPEND="${COMMONDEPEND}
	sys-devel/bc
	virtual/pkgconfig
	nls? ( sys-devel/gettext )"

pkg_setup() {
	python_set_active_version 2
	font_pkg_setup
}

src_prepare() {
	epatch "${FILESDIR}"/2.0-python.patch
	echo "#!/bin/sh" > config/py-compile
	sed "s:python -tt:$(PYTHON) -tt:g" -i lib/configure.py || die
}

src_configure() {
	tc-export CXX
	#bug 221921
	export VARTEXFONTS=${T}/fonts

	econf \
		$(use_enable nls) \
		$(use_enable debug) \
		$(use_enable monolithic-build) \
		$(use_with hunspell) \
		$(use_with aspell) \
		$(use_with enchant) \
		--without-included-boost \
		--disable-stdlib-debug \
		--with-packaging=posix
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	dodoc ANNOUNCE NEWS README RELEASE-NOTES UPGRADING "${FONT_S}"/*.txt || die

	if use linguas_he ; then
		echo "\bind_file cua" > "${T}"/hebrew.bind
		echo "\bind \"F12\" \"language hebrew\"" >> "${T}"/hebrew.bind

		insinto /usr/share/lyx/bind
		doins "${T}"/hebrew.bind || die
	fi

	newicon -s 32 "$S/development/Win32/packaging/icons/lyx_32x32.png" ${PN}.png
	make_desktop_entry ${PN} "LyX" "${PN}" "Office" "MimeType=application/x-lyx;"

	# fix for bug 91108
	if use latex ; then
		dosym ../../../lyx/tex /usr/share/texmf/tex/latex/lyx || die
	fi

	# fonts needed for proper math display, see also bug #15629
	font_src_install

	python_convert_shebangs -r 2 "${ED}"/usr/share/${PN}

	if use hunspell ; then
		dosym /usr/share/myspell /usr/share/lyx/dicts
		dosym /usr/share/myspell /usr/share/lyx/thes
	fi
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	font_pkg_postinst
	gnome2_icon_cache_update

	# fix for bug 91108
	if use latex ; then
		texhash
	fi

	# instructions for RTL support. See also bug 168331.
	if use linguas_he || use linguas_ar; then
		elog
		elog "Enabling RTL support in LyX:"
		elog "If you intend to use a RTL language (such as Hebrew or Arabic)"
		elog "You must enable RTL support in LyX. To do so start LyX and go to"
		elog "Tools->Preferences->Language settings->Language"
		elog "and make sure the \"Right-to-left language support\" is checked"
		elog
	fi
}

pkg_postrm() {
	gnome2_icon_cache_update

	if use latex ; then
		texhash
	fi
}
