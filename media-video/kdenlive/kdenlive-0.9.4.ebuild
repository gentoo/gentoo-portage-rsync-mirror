# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/kdenlive/kdenlive-0.9.4.ebuild,v 1.1 2013/02/05 13:04:13 yngwin Exp $

EAPI=5
KDE_LINGUAS="ca cs da de el es et fi fr ga gl he hr hu it ja lt nb nds nl pl pt
pt_BR ru sk sl sv tr uk zh zh_CN zh_TW"
KDE_HANDBOOK="optional"
OPENGL_REQUIRED="always"
inherit kde4-base

DESCRIPTION="A non-linear video editing suite for KDE"
HOMEPAGE="http://www.kdenlive.org/"
SRC_URI="mirror://kde/stable/${PN}/${PV}/src/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS="~amd64 ~ppc ~x86 ~x86-linux"
IUSE="debug semantic-desktop"

RDEPEND="dev-libs/qjson
	|| ( >=media-libs/mlt-0.8.6-r1[ffmpeg,sdl,xml,melt,qt4,kdenlive]
		 <=media-libs/mlt-0.8.6[ffmpeg,sdl,xml,melt,qt4,kde] )
	virtual/ffmpeg[encode,sdl,X]
	$(add_kdebase_dep kdelibs 'semantic-desktop?')"
DEPEND="${RDEPEND}"

DOCS=( AUTHORS ChangeLog README TODO )

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_with semantic-desktop Nepomuk)
	)
	kde4-base_src_configure
}
