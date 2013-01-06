# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tex/latex2rtf/latex2rtf-2.1.0.ebuild,v 1.2 2011/10/05 19:04:41 aballier Exp $

inherit toolchain-funcs

DESCRIPTION="LaTeX to RTF converter"
HOMEPAGE="http://latex2rtf.sourceforge.net/"
SRC_URI="mirror://sourceforge/latex2rtf/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
SLOT="0"
IUSE="doc test"

RDEPEND="virtual/latex-base
	media-gfx/imagemagick"
DEPEND="${RDEPEND}
	doc? ( virtual/texi2dvi )
	test? (
		dev-texlive/texlive-langgerman
		dev-texlive/texlive-fontsrecommended
		dev-tex/latex2html
	)"

src_compile() {
	export VARTEXFONTS="${T}/fonts"
	emake PREFIX="/usr" CC="$(tc-getCC)" || die "emake failed"
	if use doc; then
		cd "${S}/doc"
		emake clean || die "cleaning docs failed"
		emake || die "generating docs failed"
	fi
}

src_install() {
	dodoc README ChangeLog doc/credits
	emake PREFIX="${D}/usr" MAN_INSTALL="${D}/usr/share/man/man1" SUPPORT_INSTALL="${D}/usr/share/doc/${PF}" install || die "make install failed"
	# if doc is not used, only the text version is intalled.
	if use doc; then
		emake INFO_INSTALL="${D}/usr/share/info" install-info || die "installing info documentation failed"
	fi
}
