# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-physics/geant/geant-4.9.6_p02.ebuild,v 1.1 2013/06/05 16:14:34 bicatali Exp $

EAPI=5

inherit cmake-utils eutils fortran-2 versionator multilib

PV1=$(get_version_component_range 1 ${PV})
PV2=$(get_version_component_range 2 ${PV})
PV3=$(get_version_component_range 3 ${PV})
MYP=${PN}$(replace_version_separator 3 .)

DESCRIPTION="Toolkit for simulation of passage of particles through matter"
HOMEPAGE="http://geant4.cern.ch/"
SRC_COM="http://geant4.cern.ch/support/source"
SRC_URI="${SRC_COM}/${MYP}.tar.gz"

NDLPV=4.2
GEANT4_DATA="
	G4NDL.${NDLPV}
	G4EMLOW.6.32
	G4RadioactiveDecay.3.6
	G4SAIDDATA.1.1
	G4NEUTRONXS.1.2
	G4PII.1.3
	G4PhotonEvaporation.2.3
	G4ABLA.3.0
	RealSurface.1.0"
for d in ${GEANT4_DATA}; do
	SRC_URI="${SRC_URI} data? ( ${SRC_COM}/${d}.tar.gz ${SRC_COM}/G4NDL${NDLPV}.TS.tar.gz )"
done

LICENSE="geant4"
SLOT="4"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="+data dawn examples gdml geant3 motif opengl openinventor
	raytracerx qt4 static-libs vrml zlib"

RDEPEND="
	dev-libs/expat
	>=sci-physics/clhep-2.1.3
	dawn? ( media-gfx/dawn )
	gdml? ( dev-libs/xerces-c )
	motif? ( x11-libs/motif:0 )
	opengl? ( virtual/opengl )
	openinventor? ( media-libs/openinventor )
	qt4? ( dev-qt/qtgui:4 opengl? ( dev-qt/qtopengl:4 ) )
	raytracerx? ( x11-libs/libX11 x11-libs/libXmu )
	zlib? ( sys-libs/zlib )"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${MYP}"

PATCHES=( "${FILESDIR}"/${PN}-4.9.4-zlib.patch )
GEANT4_DATA_DIR="/usr/share/geant4/data"

src_configure() {
	local mycmakeargs=(
		-DGEANT4_USE_SYSTEM_CLHEP=ON
		-DCMAKE_INSTALL_LIBDIR="${EROOT}usr/$(get_libdir)"
		-DGEANT4_INSTALL_DATADIR="${EROOT}${GEANT4_DATA_DIR}"
		-DGEANT4_INSTALL_DATA=OFF
		$(use openinventor && echo "-DINVENTOR_SOXT_LIBRARY=${EROOT}usr/$(get_libdir)/libInventorXt.so")
		$(cmake-utils_use dawn GEANT4_USE_NETWORKDAWN)
		$(cmake-utils_use gdml GEANT4_USE_GDML)
		$(cmake-utils_use geant3 GEANT4_USE_G3TOG4)
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
	sed -i -e 's/-lG4clhep/-lCLHEP/' config/binmake.gmk || die

	cmake-utils_src_install
	if use data; then
		einfo "Installing Geant4 data"
		insinto ${GEANT4_DATA_DIR}
		pushd "${WORKDIR}" > /dev/null
		for d in ${GEANT4_DATA}; do
			local p=${d/.}
			doins -r *${p/G4}
		done
		popd > /dev/null
	fi
	insinto /usr/share/doc/${PF}
	local mypv="${PV1}.${PV2}.${PV3}"
	doins ReleaseNotes/ReleaseNotes${mypv}.html
	[[ -e ReleaseNotes/Patch${mypv}-1.txt ]] && \
		dodoc ReleaseNotes/Patch${mypv}-*.txt
	use examples && doins -r examples
	if use data ; then
		sed -n "s,export \(G4.\+DATA=\"\).*\(/share/Geant.\+/data/.\+\) > /dev/null ; pwd\`,\1${EPREFIX}/usr\2,p" \
			"${CMAKE_BUILD_DIR}/InstallTreeFiles/geant4.sh" > 99geant
		doenvd 99geant
	fi
}

pkg_postinst() {
	elog "The following scripts are provided for backward compatibility:"
	elog "$(ls -1 ${EROOT}usr/share/Geant4-${PV2}.${PV3}.*/geant4make/*sh)"
}
