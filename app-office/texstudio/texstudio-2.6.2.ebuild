# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/texstudio/texstudio-2.6.2.ebuild,v 1.2 2013/07/23 13:50:08 kensington Exp $

EAPI=5

inherit base fdo-mime qt4-r2

DESCRIPTION="Free cross-platform LaTeX editor (fork from texmakerX)"
HOMEPAGE="http://texstudio.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${PN}/TeXstudio%20${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~x86-fbsd"
IUSE="video"

COMMON_DEPEND="
	app-text/hunspell
	app-text/poppler:=[qt4]
	dev-libs/quazip
	x11-libs/libX11
	x11-libs/libXext
	|| ( ( >=dev-qt/qtgui-4.8.5:4 dev-qt/designer:4 ) <dev-qt/qtgui-4.8.5:4 )
	>=dev-qt/qtcore-4.6.1:4
	>=dev-qt/qtscript-4.6.1:4
	>=dev-qt/qtsvg-4.6.1:4
	>=dev-qt/qttest-4.6.1:4
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
	"${FILESDIR}"/${PN}-2.6.0-hunspell-quazip.patch
# 441914
#	"${FILESDIR}"/${P}-qtsingle.patch
	"${FILESDIR}"/${PN}-2.6.0-desktop.patch
# Get it from fedora
	"${FILESDIR}"/${PN}-2.5-viewers-use-xdg-open.patch
	)

src_prepare() {
	find hunspell quazip utilities/poppler-data -delete || die
	if use video; then
		sed "/^PHONON/s:$:true:g" -i ${PN}.pro || die
	fi
	qt4-r2_src_prepare
}

src_install() {
	local i
	for i in 16x16 22x22 32x32 48x48 64x64; do
		insinto /usr/share/icons/hicolor/${i}
		newins utilities/${PN}${i}.png ${PN}.png
	done
	qt4-r2_src_install
}

pkg_postinst() {
	fdo-mime_desktop_database_update
}
