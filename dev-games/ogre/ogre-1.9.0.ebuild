# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-games/ogre/ogre-1.9.0.ebuild,v 1.2 2013/12/30 21:30:16 hasufell Exp $

EAPI=5
CMAKE_REMOVE_MODULES="yes"
CMAKE_REMOVE_MODULES_LIST="FindFreetype"
inherit eutils cmake-utils vcs-snapshot

DESCRIPTION="Object-oriented Graphics Rendering Engine"
HOMEPAGE="http://www.ogre3d.org/"
SRC_URI="https://bitbucket.org/sinbad/ogre/get/v${PV//./-}.tar.bz2 -> ${P}.tar.bz2"

LICENSE="MIT public-domain"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+boost cg doc double-precision examples +freeimage gles2 ois +opengl poco profile tbb threads tools +zip"
REQUIRED_USE="threads? ( ^^ ( boost poco tbb ) )
	poco? ( threads )
	tbb? ( threads )"
RESTRICT="test" #139905

RDEPEND="
	dev-libs/tinyxml
	media-libs/freetype:2
	virtual/opengl
	virtual/glu
	x11-libs/libX11
	x11-libs/libXaw
	x11-libs/libXrandr
	x11-libs/libXt
	boost? ( dev-libs/boost )
	cg? ( media-gfx/nvidia-cg-toolkit )
	freeimage? ( media-libs/freeimage )
	gles2? ( >=media-libs/mesa-8.0.0[gles2] )
	ois? ( dev-games/ois )
	threads? (
		poco? ( dev-libs/poco )
		tbb? ( dev-cpp/tbb )
	)
	zip? ( sys-libs/zlib dev-libs/zziplib )"
# gles1 currently broken wrt bug #418201
DEPEND="${RDEPEND}
	x11-proto/xf86vidmodeproto
	virtual/pkgconfig
	doc? ( app-doc/doxygen )"

src_prepare() {
	sed -i \
		-e "s:share/OGRE/docs:share/doc/${PF}:" \
		Docs/CMakeLists.txt || die
	# Stupid build system hardcodes release names
	sed -i \
		-e '/CONFIGURATIONS/s:CONFIGURATIONS Release.*::' \
		CMake/Utils/OgreConfigTargets.cmake || die
}

src_configure() {
	local mycmakeargs=(
		-DOGRE_FULL_RPATH=NO
		$(cmake-utils_use boost OGRE_USE_BOOST)
		$(cmake-utils_use cg OGRE_BUILD_PLUGIN_CG)
		$(cmake-utils_use doc OGRE_INSTALL_DOCS)
		$(cmake-utils_use double-precision OGRE_CONFIG_DOUBLE)
		$(cmake-utils_use examples OGRE_INSTALL_SAMPLES)
		$(cmake-utils_use freeimage OGRE_CONFIG_ENABLE_FREEIMAGE)
		$(cmake-utils_use opengl OGRE_BUILD_RENDERSYSTEM_GL)
		-DOGRE_BUILD_RENDERSYSTEM_GLES=OFF
		$(cmake-utils_use gles2 OGRE_BUILD_RENDERSYSTEM_GLES2)
		$(cmake-utils_use profile OGRE_PROFILING)
		$(cmake-utils_use examples OGRE_BUILD_SAMPLES)
		-DOGRE_BUILD_TESTS=FALSE
		$(usex threads "-DOGRE_CONFIG_THREADS=2" "-DOGRE_CONFIG_THREADS=0")
		$(cmake-utils_use tools OGRE_BUILD_TOOLS)
		$(cmake-utils_use zip OGRE_CONFIG_ENABLE_ZIP)
	)

	if use threads ; then
		local f
		for f in boost poco tbb ; do
			use ${f} || continue
			mycmakeargs+=( -DOGRE_CONFIG_THREAD_PROVIDER=${f} )
			break
		done
	fi

	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install
	docinto examples
	dodoc "${CMAKE_BUILD_DIR}"/bin/*.cfg
}
