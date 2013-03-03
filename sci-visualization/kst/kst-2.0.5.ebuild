# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-visualization/kst/kst-2.0.5.ebuild,v 1.2 2013/03/02 23:28:06 hwoarang Exp $

EAPI=4

CMAKE_USE_DIR=${S}/cmake

inherit cmake-utils multilib

DESCRIPTION="Fast real-time large-dataset viewing and plotting tool for KDE4"
HOMEPAGE="http://kst.kde.org/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2 LGPL-2 FDL-1.2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug test"
RESTRICT="test"

RDEPEND="
	sci-libs/cfitsio
	sci-libs/getdata
	sci-libs/gsl
	sci-libs/netcdf[cxx]
	dev-qt/qtcore:4
	dev-qt/qtgui:4
	dev-qt/qtopengl:4
	dev-qt/qtsvg:4
"
DEPEND="${RDEPEND}
	test? ( dev-qt/qttest:4 )
"

DOCS=( AUTHORS ChangeLog )
PATCHES=( "${FILESDIR}/${PN}-2.0.4-cfitsio-includes.patch" )

src_prepare() {
	base_src_prepare

	# fix desktop file
	sed -i -e 's/^Categories=/&Education;/' \
		-e '/^Encoding=/d' \
		src/kst/kst2.desktop || die
}

src_configure() {
	local mycmakeargs=(
		-Dkst_install_libdir=$(get_libdir)
		-Dkst_pch=OFF
		-Dkst_release=$(use debug && echo OFF || echo ON)
		-Dkst_rpath=OFF
		-Dkst_svnversion=OFF
		$(cmake-utils_use test kst_test)
	)
	cmake-utils_src_configure
}
