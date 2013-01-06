# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-geosciences/qgis/qgis-1.7.4.ebuild,v 1.2 2012/05/24 12:53:24 scarabeus Exp $

EAPI=4

PYTHON_USE_WITH="sqlite"
PYTHON_DEPEND="python? 2"
inherit python base cmake-utils eutils multilib

DESCRIPTION="User friendly Geographic Information System"
HOMEPAGE="http://www.qgis.org/"
SRC_URI="http://qgis.org/downloads/${P}.tar.bz2
	examples? ( http://download.osgeo.org/qgis/data/qgis_sample_data.tar.gz )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="examples gps grass gsl postgres python spatialite test"

RDEPEND="
	dev-libs/expat
	sci-geosciences/gpsbabel
	>=sci-libs/gdal-1.6.1[geos,python?]
	sci-libs/geos
	sci-libs/gsl
	x11-libs/qt-core:4
	x11-libs/qt-gui:4
	x11-libs/qt-svg:4
	x11-libs/qt-sql:4
	x11-libs/qt-webkit:4
	x11-libs/qwt:5[svg]
	<x11-libs/qwtpolar-1
	grass? ( >=sci-geosciences/grass-6.4.0_rc6[python?] )
	postgres? ( >=dev-db/postgresql-base-8.4 )
	python? (
		<dev-python/PyQt4-4.9[X,sql,svg]
		<dev-python/sip-4.13
	)
	spatialite? (
		dev-db/sqlite:3
		dev-db/spatialite
	)"

DEPEND="${RDEPEND}
	sys-devel/bison
	sys-devel/flex"

DOCS=( BUGS CHANGELOG CODING.pdf README )

PATCHES=(
	"${FILESDIR}/${P}-gcc4.7.patch"
	"${FILESDIR}/${PN}-no-python-pyc.patch"
)

# Does not find the test binaries at all
RESTRICT="test"

pkg_setup() {
	if use python ; then
		python_set_active_version 2
		python_pkg_setup
	fi
}

src_configure() {
	local mycmakeargs+=(
		"-DQGIS_MANUAL_SUBDIR=/share/man/"
		"-DBUILD_SHARED_LIBS=ON"
		"-DBINDINGS_GLOBAL_INSTALL=ON"
		"-DQGIS_LIB_SUBDIR=$(get_libdir)"
		"-DQGIS_PLUGIN_SUBDIR=$(get_libdir)/qgis"
		"-DWITH_INTERNAL_SPATIALITE=OFF"
		"-DWITH_INTERNAL_QWTPOLAR=OFF"
		"-DPEDANTIC=OFF"
		"-DWITH_APIDOC=OFF"
		$(cmake-utils_use_with postgres POSTGRESQL)
		$(cmake-utils_use_with grass GRASS)
		$(cmake-utils_use_with python BINDINGS)
		$(cmake-utils_use python BINDINGS_GLOBAL_INSTALL)
		$(cmake-utils_use_with spatialite SPATIALITE)
		$(cmake-utils_use_enable test TESTS)
	)
	use grass && mycmakeargs+=( "-DGRASS_PREFIX=/usr/" )

	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install

	newicon images/icons/qgis-icon.png qgis.png
	make_desktop_entry qgis "Quantum GIS" qgis

	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		doins -r "${WORKDIR}"/qgis_sample_data/*
	fi
}

pkg_postinst() {
	if use postgres; then
		elog "If you don't intend to use an external PostGIS server"
		elog "you should install:"
		elog "   dev-db/postgis"
	fi
	use python && python_mod_optimize qgis /usr/share/qgis/python/plugins
}

pkg_postrm() {
	use python && python_mod_cleanup qgis /usr/share/qgis/python/plugins
}
