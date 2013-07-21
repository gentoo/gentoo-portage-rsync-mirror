# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-geosciences/osgearth/osgearth-2.4.ebuild,v 1.2 2013/07/21 17:58:13 hasufell Exp $

EAPI=5

inherit cmake-utils

DESCRIPTION="Dynamic map generation toolkit for OpenSceneGraph"
HOMEPAGE="http://osgearth.org/"
SRC_URI="https://github.com/gwaldron/osgearth/archive/${P}.tar.gz"

LICENSE="LGPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc qt4"

RDEPEND="
	dev-db/sqlite:3
	dev-games/openscenegraph[curl,qt4?]
	dev-lang/v8:=
	dev-libs/tinyxml
	net-misc/curl
	sci-libs/gdal
	sci-libs/geos
	sys-libs/zlib[minizip]
	virtual/opengl
	x11-libs/libX11
	qt4? (
		dev-qt/qtcore:4
		dev-qt/qtgui:4
		dev-qt/qtopengl:4
	)"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	doc? ( dev-python/sphinx )"

S=${WORKDIR}/${PN}-${P}

PATCHES=( "${FILESDIR}"/${P}-FindMiniZip.cmake.patch )

src_configure() {
	local mycmakeargs=(
		-DWITH_EXTERNAL_TINYXML=ON
		$(cmake-utils_use qt4 OSGEARTH_USE_QT)
	)

	cmake-utils_src_configure
}

src_compile() {
	cmake-utils_src_compile

	if use doc ; then
		emake -C "${S}"/docs man html info
	fi
}

src_install() {
	cmake-utils_src_install

	if use doc ; then
		dohtml -r "${S}"/docs/build/html/*
		doman "${S}"/docs/build/man/*
		doinfo "${S}"/docs/build/texinfo/*.info*
	fi
}
