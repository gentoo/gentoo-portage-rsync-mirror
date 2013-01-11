# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/kaffeine/kaffeine-1.2.2.ebuild,v 1.6 2013/01/11 21:15:00 dilfridge Exp $

EAPI=4

KDE_LINGUAS="ar ast be bg ca ca@valencia cs da de el en_GB eo es et fi fr ga gl hr hu
	it ja km ko ku lt mai nb nds nl nn pa pl pt pt_BR ro ru se sk sr@ijekavian
	sr@ijekavianlatin sr@latin sv th tr uk zh_CN zh_TW"
KDE_SCM="git"
inherit kde4-base

DESCRIPTION="A media player for KDE with digital TV support"
HOMEPAGE="http://kaffeine.kde.org/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2 FDL-1.2"
SLOT="4"
KEYWORDS="amd64 ppc x86"
IUSE="debug"

DEPEND="
	x11-libs/libXScrnSaver
	x11-libs/qt-sql:4[sqlite]
	>=media-libs/xine-lib-1.1.18.1
	$(add_kdebase_dep solid)
"
RDEPEND="${DEPEND}"

DOCS=( Changelog NOTES )

PATCHES=( "${FILESDIR}/${PN}-1.2.2-gcc4.7.patch" )

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_build debug DEBUG_MODULE)
	)

	kde4-base_src_configure
}
