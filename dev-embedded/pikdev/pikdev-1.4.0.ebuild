# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-embedded/pikdev/pikdev-1.4.0.ebuild,v 1.1 2013/12/25 18:52:32 rafaelmartins Exp $

EAPI=5

inherit qt4-r2 eutils

DESCRIPTION="Simple graphic IDE for the development of PIC-based applications."
HOMEPAGE="http://pikdev.free.fr/"
SRC_URI="http://pikdev.free.fr/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-qt/qtcore
	dev-qt/qtgui
	dev-qt/qt3support
	dev-qt/qtwebkit"
RDEPEND="${DEPEND}
	>=dev-embedded/gputils-1.0.0"

S="${WORKDIR}/${P}/src"

src_prepare() {
	rm pkp.pro || die 'rm failed'  # TODO: support pkp, maybe with a separated package

	qt4-r2_src_prepare
}

src_install() {
	qt4-r2_src_install

	doicon icons/256/pikdev-app-v4.png
	make_desktop_entry pikdev 'PIKdev for Qt4' pikdev-app-v4
	dosym "${P}" "/usr/bin/${PN}"
}

pkg_postinst() {
	elog "Additional packages that you may want to install:"
	elog
	elog "- dev-embedded/cpik - C compiler for PIC18 devices"
	elog "- dev-embedded/pk2cmd - Microchip PicKit2 PIC programmer support"
	elog
}
