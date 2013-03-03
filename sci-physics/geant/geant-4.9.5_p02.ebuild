# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-physics/geant/geant-4.9.5_p02.ebuild,v 1.2 2013/03/02 23:26:38 hwoarang Exp $

EAPI=4

inherit cmake-utils eutils fortran-2 versionator multilib

PV1=$(get_version_component_range 1 ${PV})
PV2=$(get_version_component_range 2 ${PV})
PV3=$(get_version_component_range 3 ${PV})
MYP=${PN}$(replace_version_separator 3 .)

DESCRIPTION="Toolkit for simulation of passage of particles through matter"
HOMEPAGE="http://geant4.cern.ch/"
SRC_URI="http://geant4.cern.ch/support/source/${MYP}.tar.gz"

LICENSE="geant4"
SLOT="4"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="+data dawn examples gdml geant3 granular motif opengl openinventor
	raytracerx qt4 static-libs vrml zlib"

RDEPEND="
	>=sci-physics/clhep-2.1.1
	dawn? ( media-gfx/dawn )
	gdml? ( dev-libs/xerces-c )
	motif? ( x11-libs/motif:0 )
	opengl? ( virtual/opengl )
	openinventor? ( media-libs/openinventor )
	raytracerx? ( x11-libs/libX11 x11-libs/libXmu )
	qt4? ( dev-qt/qtgui:4 opengl? ( dev-qt/qtopengl:4 ) )
	zlib? ( sys-libs/zlib )"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${MYP}"

PATCHES=(
	"${FILESDIR}"/${PN}-4.9.4-zlib.patch
	"${FILESDIR}"/${PN}-4.9.5_p01-scripts-only-dataenv.patch )

src_configure() {
	local mycmakeargs=(
		-DGEANT4_USE_SYSTEM_CLHEP=ON
		-DCMAKE_INSTALL_LIBDIR="${EROOT}usr/$(get_libdir)"
		$(use openinventor && echo "-DINVENTOR_SOXT_LIBRARY=${EROOT}usr/$(get_libdir)/libInventorXt.so")
		$(cmake-utils_use data GEANT4_INSTALL_DATA)
		$(cmake-utils_use dawn GEANT4_USE_NETWORKDAWN)
		$(cmake-utils_use gdml GEANT4_USE_GDML)
		$(cmake-utils_use geant3 GEANT4_USE_G3TOG4)
		$(cmake-utils_use granular GEANT4_BUILD_GRANULAR_BUILD)
		$(cmake-utils_use motif GEANT4_USE_XM)
		$(cmake-utils_use opengl GEANT4_USE_OPENGL_X11)
		$(cmake-utils_use openinventor GEANT4_USE_INVENTOR)
		$(cmake-utils_use qt4 GEANT4_USE_QT)
		$(cmake-utils_use raytracerx GEANT4_USE_RAYTRACER_X11)
		$(cmake-utils_use vrml GEANT4_USE_NETWORKVRML)
		$(cmake-utils_use zlib GEANT4_USE_SYSTEM_ZLIB)
		$(cmake-utils_use_build static-libs STATIC_LIBS)
	)
	cmake-utils_src_configure
}

src_install() {
	# adjust clhep linking flags for system clhep
	# binmake.gmk is only useful for legacy build systems
	sed -i "s,-lG4clhep,-lCLHEP," config/binmake.gmk || die "sed failed"

	cmake-utils_src_install
	insinto /usr/share/doc/${PF}
	local mypv="${PV1}.${PV2}.${PV3}"
	doins ReleaseNotes/ReleaseNotes${mypv}.html
	[[ -e ReleaseNotes/Patch${mypv}-1.txt ]] && \
		dodoc ReleaseNotes/Patch${mypv}-*.txt
	use examples && doins -r examples
	if use data ; then
		sed "s,export \(G4.\+DATA=\"\).*\(/share/Geant.\+/data/.\+\); pwd\`,\1${EPREFIX}/usr\2," \
			"${CMAKE_BUILD_DIR}/InstallTreeFiles/geant4.sh" > 99geant
		doenvd 99geant
	fi
}

pkg_postinst() {
	elog "The following scripts are provided for backward compatibility:"
	elog "$(ls -1 ${EROOT}usr/share/Geant4-${PV2}.${PV3}.*/geant4make/*sh)"
}
