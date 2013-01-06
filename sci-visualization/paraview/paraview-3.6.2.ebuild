# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-visualization/paraview/paraview-3.6.2.ebuild,v 1.18 2012/05/06 23:13:07 pesa Exp $

EAPI="3"

PYTHON_DEPEND="python? 2:2.6"

inherit eutils flag-o-matic toolchain-funcs versionator python cmake-utils

MAIN_PV=$(get_major_version)
MAJOR_PV=$(get_version_component_range 1-2)

DESCRIPTION="ParaView is a powerful scientific data visualization application"
HOMEPAGE="http://www.paraview.org"
SRC_URI="mirror://gentoo/${P}.tar.gz
	mirror://gentoo/${P}-openfoam-gpl-r173.patch.bz2
	mirror://gentoo/${P}-openfoam-r173.patch.bz2"

LICENSE="paraview GPL-2"
KEYWORDS="~amd64 ~ppc ~x86"
SLOT="0"
IUSE="boost cg doc examples +gui mpi mysql plugins +python postgres streaming odbc overview"
RDEPEND="sci-libs/hdf5[mpi=]
	mpi? ( || (
				sys-cluster/openmpi
				sys-cluster/mpich2[cxx] ) )
	gui? ( x11-libs/qt-gui:4
			x11-libs/qt-qt3support:4
			x11-libs/qt-opengl:4
			|| ( >=x11-libs/qt-assistant-4.7.0:4[compat]
				<x11-libs/qt-assistant-4.7.0:4 ) )
	mysql? ( virtual/mysql )
	postgres? ( dev-db/postgresql-base )
	odbc? ( dev-db/unixODBC )
	dev-libs/libxml2:2
	media-libs/libpng
	virtual/jpeg
	media-libs/tiff
	virtual/ffmpeg
	dev-libs/expat
	sys-libs/zlib
	media-libs/freetype
	>=app-admin/eselect-opengl-1.0.6-r1
	virtual/opengl
	sci-libs/netcdf
	x11-libs/libXmu"

DEPEND="${RDEPEND}
		boost? (  >=dev-libs/boost-1.40.0 )
		doc? ( app-doc/doxygen )
		>=dev-util/cmake-2.6.4"

PVLIBDIR="$(get_libdir)/${PN}-${MAJOR_PV}"
S="${WORKDIR}"/ParaView${MAIN_PV}

pkg_setup() {
	if (use overview) && (! use gui); then
		die "the overview plugin requires the USE='gui'"
	fi
	use python && python_set_active_version 2
}

src_prepare() {
	epatch "${FILESDIR}"/${P}-qt.patch
	epatch "${FILESDIR}"/${P}-findcg-cmake.patch
	epatch "${FILESDIR}"/${P}-assistant.patch
	epatch "${DISTDIR}"/${P}-openfoam-r173.patch.bz2
	epatch "${DISTDIR}"/${P}-openfoam-gpl-r173.patch.bz2
	epatch "${FILESDIR}"/${P}-no-doc-finder.patch
	epatch "${FILESDIR}"/${P}-pointsprite-disable.patch
	epatch "${FILESDIR}"/${P}-about.html.patch
	epatch "${FILESDIR}"/${P}-boost-property_map.patch
	epatch "${FILESDIR}"/${P}-odbc.patch
	epatch "${FILESDIR}"/${P}-h5part.patch
	epatch "${FILESDIR}"/${P}-libpng14.patch
	epatch "${FILESDIR}"/${P}-libpng15.patch

	if has_version '>=sci-libs/hdf5-1.8.0'; then
		epatch "${FILESDIR}"/${P}-hdf-1.8.3.patch
	fi

	# fix GL issues
	sed -e "s:DEPTH_STENCIL_EXT:DEPTH_COMPONENT24:" \
		-i VTK/Rendering/vtkOpenGLRenderWindow.cxx \
		|| die "Failed to fix GL issues."

	# fix plugin install directory
	sed -e "s:\${PV_INSTALL_BIN_DIR}/plugins:/usr/${PVLIBDIR}/plugins:" \
		-i CMake/ParaViewPlugins.cmake \
		|| die "Failed to fix plugin install directories"

	# bug 348151
	sed -e 's/CURRENT_VERSION 2.6/CURRENT_VERSION 2.7 2.6/' \
		-i VTK/CMake/FindPythonLibs.cmake || die
}

src_configure() {
	mycmakeargs=(
	  -DPV_INSTALL_LIB_DIR="${PVLIBDIR}"
	  -DCMAKE_INSTALL_PREFIX=/usr
	  -DEXPAT_INCLUDE_DIR=/usr/include
	  -DEXPAT_LIBRARY=/usr/$(get_libdir)/libexpat.so
	  -DOPENGL_gl_LIBRARY=/usr/$(get_libdir)/libGL.so
	  -DOPENGL_glu_LIBRARY=/usr/$(get_libdir)/libGLU.so
	  -DCMAKE_SKIP_RPATH=YES
	  -DVTK_USE_RPATH=OFF
	  -DBUILD_SHARED_LIBS=ON
	  -DVTK_USE_SYSTEM_FREETYPE=ON
	  -DVTK_USE_SYSTEM_JPEG=ON
	  -DVTK_USE_SYSTEM_PNG=ON
	  -DVTK_USE_SYSTEM_TIFF=ON
	  -DVTK_USE_SYSTEM_ZLIB=ON
	  -DVTK_USE_SYSTEM_EXPAT=ON
	  -DPARAVIEW_USE_SYSTEM_HDF5=ON
	  -DCMAKE_VERBOSE_MAKEFILE=OFF
	  -DCMAKE_COLOR_MAKEFILE=TRUE
	  -DVTK_USE_SYSTEM_LIBXML2=ON
	  -DVTK_USE_OFFSCREEN=TRUE
	  -DCMAKE_USE_PTHREADS=ON
	  -DBUILD_TESTING=OFF
	  -DVTK_USE_FFMPEG_ENCODER=OFF)

	# use flag triggered options
	mycmakeargs+=(
	  $(cmake-utils_use gui PARAVIEW_BUILD_QT_GUI)
	  $(cmake-utils_use gui VTK_USE_QVTK)
	  $(cmake-utils_use gui VTK_USE_QVTK_QTOPENGL)
	  $(cmake-utils_use boost VTK_USE_BOOST)
	  $(cmake-utils_use mpi PARAVIEW_USE_MPI)
	  $(cmake-utils_use python PARAVIEW_ENABLE_PYTHON)
	  $(cmake-utils_use doc BUILD_DOCUMENTATION)
	  $(cmake-utils_use examples BUILD_EXAMPLES)
	  $(cmake-utils_use cg VTK_USE_CG_SHADERS)
	  $(cmake-utils_use streaming PARAVIEW_BUILD_StreamingParaView)
	  $(cmake-utils_use odbc VTK_USE_ODBC)
	  $(cmake-utils_use mysql VTK_USE_MYSQL)
	  $(cmake-utils_use mysql XDMF_USE_MYSQL)
	  $(cmake-utils_use postgres VTK_USE_POSTGRES))

	if use gui; then
		mycmakeargs+=(-DVTK_INSTALL_QT_DIR=/${PVLIBDIR}/plugins/designer)
	fi

	# all the logic needed for overview
	# we enable all plugins that are either required by overview
	# or require overview to work
	mycmakeargs+=(
	  $(cmake-utils_use overview VTK_USE_N_WAY_ARRAYS)
	  $(cmake-utils_use overview PARAVIEW_BUILD_OverView)
	  $(cmake-utils_use overview PARAVIEW_BUILD_PLUGIN_ClientGraphView)
	  $(cmake-utils_use overview PARAVIEW_BUILD_PLUGIN_ClientGraphViewFrame)
	  $(cmake-utils_use overview PARAVIEW_BUILD_PLUGIN_ClientRecordView)
	  $(cmake-utils_use overview PARAVIEW_BUILD_PLUGIN_ClientTableView)
	  $(cmake-utils_use overview PARAVIEW_BUILD_PLUGIN_ClientTreeView)
	  $(cmake-utils_use overview PARAVIEW_BUILD_PLUGIN_Infovis)
	  $(cmake-utils_use overview PARAVIEW_BUILD_PLUGIN_SQLDatabaseGraphSourcePanel)
	  $(cmake-utils_use overview PARAVIEW_BUILD_PLUGIN_SQLDatabaseTableSourcePanel)
	  $(cmake-utils_use overview PARAVIEW_BUILD_PLUGIN_TableToGraphPanel)
	  $(cmake-utils_use overview PARAVIEW_BUILD_PLUGIN_Array)
	  $(cmake-utils_use overview PARAVIEW_BUILD_PLUGIN_ClientGeoView)
	  $(cmake-utils_use overview PARAVIEW_BUILD_PLUGIN_ClientGeoView2D)
	  $(cmake-utils_use overview PARAVIEW_BUILD_PLUGIN_ClientGraphViewFrame)
	  $(cmake-utils_use overview PARAVIEW_BUILD_PLUGIN_ClientHierarchyView)
	  $(cmake-utils_use overview PARAVIEW_BUILD_PLUGIN_CommonToolbar)
	  $(cmake-utils_use overview PARAVIEW_BUILD_PLUGIN_GraphLayoutFilterPanel)
	  $(cmake-utils_use overview PARAVIEW_BUILD_PLUGIN_SplitTableFieldPanel)
	  $(cmake-utils_use overview PARAVIEW_BUILD_PLUGIN_StatisticsToolbar)
	  $(cmake-utils_use overview PARAVIEW_BUILD_PLUGIN_TableToSparseArrayPanel)
	  $(cmake-utils_use overview PARAVIEW_BUILD_PLUGIN_ThresholdTablePanel))

	# the rest of the plugins
	mycmakeargs+=(
	  $(cmake-utils_use plugins PARAVIEW_BUILD_PLUGIN_ChartViewFrame)
	  $(cmake-utils_use plugins PARAVIEW_BUILD_PLUGIN_ClientAttributeView)
	  $(cmake-utils_use plugins PARAVIEW_BUILD_PLUGIN_ClientChartView)
	  $(cmake-utils_use plugins PARAVIEW_BUILD_PLUGIN_CosmoFilters)
	  $(cmake-utils_use plugins PARAVIEW_BUILD_PLUGIN_H5PartReader)
	  $(cmake-utils_use plugins PARAVIEW_BUILD_PLUGIN_Moments)
	  $(cmake-utils_use plugins PARAVIEW_BUILD_PLUGIN_PointSprite)
	  $(cmake-utils_use plugins PARAVIEW_BUILD_PLUGIN_Prism)
	  $(cmake-utils_use plugins PARAVIEW_BUILD_PLUGIN_SLACTools)
	  $(cmake-utils_use plugins PARAVIEW_BUILD_PLUGIN_Streaming)
	  $(cmake-utils_use plugins PARAVIEW_BUILD_PLUGIN_netCDFReaders))

	if use python; then
	  mycmakeargs+=($(cmake-utils_use plugins PARAVIEW_BUILD_PLUGIN_pvblot))
	fi

	# we also need to append -DH5Tget_array_dims_vers=1 to our CFLAGS
	# to make sure we can compile against >=hdf5-1.8.3
	append-flags -DH5_USE_16_API

	cmake-utils_src_configure
	# overview needs a second configure to pick things up
	use overview && cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install

	# rename the assistant wrapper
	if use gui; then
		mv "${D}"/usr/bin/assistant "${D}"/usr/bin/paraview-assistant \
			|| die "Failed to rename assistant wrapper"
		chmod 0755 "${D}"/usr/${PVLIBDIR}/assistant-real \
			|| die "Failed to change permissions on assistant wrapper"
	fi

	# since there is no install target for OverView we have to
	# do things manually
	if use overview; then
		exeinto /usr/"${PVLIBDIR}"
		newexe "${CMAKE_BUILD_DIR}"/bin/OverView OverView-real \
			|| die "Failed to install OverView binary"
		dolib.so "${CMAKE_BUILD_DIR}"/bin/libOverViewCore.so \
			|| die "Failed to install OverViewCore shared object"

		insinto /usr/"${PVLIBDIR}"/OverView-startup
		insopts -m0744
		doins "${CMAKE_BUILD_DIR}"/bin/OverView-startup/lib*.so \
			|| die "Failed to install OverView libraries"

		dosym /usr/"${PVLIBDIR}"/OverView-real /usr/bin/OverView \
			|| die "Failed to create OverView symlink"

		newicon "${S}"/Applications/OverView/Icon.png overview.png \
			|| die "Failed to create OverView icon"
		make_desktop_entry OverView "OverView" overview \
			|| die "Failed to install OverView desktop icon"
	fi

	# set up the environment
	echo "LDPATH=/usr/${PVLIBDIR}" >> "${T}"/40${PN}
	echo "PYTHONPATH=/usr/${PVLIBDIR}" >> "${T}"/40${PN}
	doenvd "${T}"/40${PN}

	# this binary does not work and probably should not be installed
	rm -f "${D}/usr/bin/vtkSMExtractDocumentation" \
		|| die "Failed to remove vtkSMExtractDocumentation"

	# rename /usr/bin/lproj to /usr/bin/lproj_paraview to avoid
	# a file collision with vtk which installs the same file
	mv "${D}/usr/bin/lproj" "${D}/usr/bin/lproj_paraview"  \
		|| die "Failed to rename /usr/bin/lproj"

	# last but not least lets make a desktop entry
	newicon "${S}"/Applications/Client/ParaViewLogo.png paraview.png \
		|| die "Failed to create paraview icon."
	make_desktop_entry paraview "Paraview" paraview \
		|| die "Failed to install Paraview desktop entry"

}

pkg_postinst() {
	# with Qt4.5 there seem to be issues reading data files
	# under certain locales. Setting LC_ALL=C should fix these.
	echo
	elog "If you experience data corruption during parsing of"
	elog "data files with paraview please try setting your"
	elog "locale to LC_ALL=C."
	elog "The binary /usr/bin/lproj has been renamed to"
	elog "/usr/bin/lproj_paraview to avoid a file collision"
	elog "with vtk."
	echo
}
