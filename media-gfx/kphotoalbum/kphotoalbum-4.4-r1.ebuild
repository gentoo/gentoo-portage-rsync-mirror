# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/kphotoalbum/kphotoalbum-4.4-r1.ebuild,v 1.2 2014/05/13 18:04:45 johu Exp $

EAPI=5

KDE_LINGUAS="ar be bg bs ca ca@valencia cs da de el en_GB eo es et eu fi fr ga
gl hi hne hr hu is it ja km lt mai nb nds nl nn pa pl pt pt_BR ro ru se sk sv
tr ug uk vi zh_CN zh_TW"
inherit kde4-base

DESCRIPTION="KDE Photo Album is a tool for indexing, searching, and viewing images"
HOMEPAGE="http://www.kphotoalbum.org/"
SRC_URI="mirror://kde/stable/${PN}/${PV}/src/${P}.tar.bz2"

LICENSE="GPL-2 FDL-1.2"
KEYWORDS="~amd64 ~x86"
SLOT="4"
IUSE="debug +exif +geolocation +kipi nepomuk +raw"

DEPEND="
	$(add_kdebase_dep kdelibs 'nepomuk?')
	>=dev-qt/qtsql-4.4:4[sqlite]
	virtual/jpeg
	exif? ( >=media-gfx/exiv2-0.17 )
	geolocation? ( $(add_kdebase_dep marble) )
	kipi? ( $(add_kdebase_dep libkipi '' 4.9.58) )
	raw? ( $(add_kdebase_dep libkdcraw '' 4.9.58) )
"
RDEPEND="${DEPEND}
	nepomuk? ( $(add_kdebase_dep nepomuk) )
	|| ( media-video/mplayer2 media-video/mplayer )
"

DOCS=( ChangeLog README TODO )

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_with exif Exiv2)
		$(cmake-utils_use_with geolocation Marble)
		$(cmake-utils_use_with kipi)
		$(cmake-utils_use_with raw Kdcraw)
		$(cmake-utils_use_with nepomuk)
		$(cmake-utils_use_with nepomuk Soprano)
	)

	kde4-base_src_configure
}
