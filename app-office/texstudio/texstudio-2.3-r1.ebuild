# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/texstudio/texstudio-2.3-r1.ebuild,v 1.3 2013/03/02 19:38:36 hwoarang Exp $

EAPI=4

inherit base fdo-mime qt4-r2

DESCRIPTION="Free cross-platform LaTeX editor (former texmakerX)"
HOMEPAGE="http://texstudio.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${PN}/TeXstudio%20${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~x86-fbsd"
IUSE="video"

COMMON_DEPEND="
	app-text/hunspell
	app-text/poppler[qt4]
	x11-libs/libX11
	x11-libs/libXext
	>=dev-qt/qtgui-4.6.1:4
	>=dev-qt/qtcore-4.6.1:4
	>=dev-qt/qtscript-4.6.1:4
	>=dev-qt/qttest-4.6.1:4
	>=dev-qt/qtwebkit-4.6.1:4
	video? ( media-libs/phonon )"
RDEPEND="${COMMON_DEPEND}
	virtual/latex-base
	app-text/psutils
	app-text/ghostscript-gpl
	media-libs/netpbm"
DEPEND="${COMMON_DEPEND}
	virtual/pkgconfig"

S="${WORKDIR}"/${P/-/}

PATCHES=(
	"${FILESDIR}"/${P}-hunspell.patch
	"${FILESDIR}"/${P}-gcc47.patch
	"${FILESDIR}"/${P}-test.patch
	"${FILESDIR}"/${P}-xdg-open.patch
	)

src_prepare() {
	find hunspell -delete
	sed 's:hunspell/hunspell:hunspell:g' -i *.h || die
	if use video; then
		sed "/^PHONON/s:$:true:g" -i ${PN}.pro || die
	fi
	qt4-r2_src_prepare
}

src_install() {
	make_desktop_entry texstudio "LaTeX Editor" texstudio "text/X-tex"
	for i in 16x16 22x22 32x32 48x48 64x64; do
		insinto /usr/share/icons/hicolor/${i}
		newins utilities/${PN}${i}.png ${PN}.png
	done
	qt4-r2_src_install
}

pkg_postinst() {
	fdo-mime_desktop_database_update
}
