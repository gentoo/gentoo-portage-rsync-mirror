# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/blender/blender-2.64a.ebuild,v 1.2 2012/12/31 16:02:50 flameeyes Exp $

EAPI=4
PYTHON_DEPEND="3:3.2"

PATCHSET="1"

inherit multilib scons-utils eutils python versionator flag-o-matic toolchain-funcs pax-utils check-reqs

IUSE="cycles +game-engine player +elbeem +openexr ffmpeg jpeg2k openal
	openmp +dds fftw jack doc sndfile tweak-mode sdl sse redcode
	iconv collada 3dmouse debug nls"
REQUIRED_USE="player? ( game-engine ) redcode? ( jpeg2k )"

LANGS="en ar bg ca cs de el es es_ES fa fi fr he hr hu id it ja ky ne nl pl pt pt_BR ru sr sr@latin sv tr uk zh_CN zh_TW"
for X in ${LANGS} ; do
	IUSE+=" linguas_${X}"
	REQUIRED_USE+=" linguas_${X}? ( nls )"
done

DESCRIPTION="3D Creation/Animation/Publishing System"
HOMEPAGE="http://www.blender.org"

case ${PV} in
	*_p*)
		SRC_URI="http://dev.gentoo.org/~lu_zero/${P}.tar.gz" ;;
	*)
		SRC_URI="http://download.blender.org/source/${P}.tar.gz" ;;
esac

if [[ -n ${PATCHSET} ]]; then
	SRC_URI+=" http://dev.gentoo.org/~flameeyes/${PN}/${P}-patches-${PATCHSET}.tar.xz"
fi

SLOT="0"
LICENSE="|| ( GPL-2 BL )"
KEYWORDS="~amd64 ~x86"

RDEPEND="virtual/jpeg
	media-libs/libpng:0
	x11-libs/libXi
	x11-libs/libX11
	media-libs/tiff:0
	media-libs/libsamplerate
	virtual/opengl
	virtual/glu
	>=media-libs/freetype-2.0
	virtual/libintl
	media-libs/glew
	>=sci-physics/bullet-2.78[-double-precision]
	dev-cpp/eigen:3
	sci-libs/colamd
	sci-libs/ldl
	dev-cpp/glog[gflags]
	sys-libs/zlib
	cycles? (
		media-libs/openimageio
		>=dev-libs/boost-1.44[threads(+)]
	)
	iconv? ( dev-libs/libiconv )
	sdl? ( media-libs/libsdl[audio,joystick] )
	openexr? ( media-libs/openexr )
	ffmpeg? (
		>=virtual/ffmpeg-0.6.90[x264,mp3,encode,theora,jpeg2k?]
	)
	openal? ( >=media-libs/openal-1.6.372 )
	fftw? ( sci-libs/fftw:3.0 )
	jack? ( media-sound/jack-audio-connection-kit )
	sndfile? ( media-libs/libsndfile )
	collada? ( media-libs/opencollada )
	3dmouse? ( dev-libs/libspnav )"

DEPEND="dev-util/scons
	doc? (
		dev-python/sphinx
		app-doc/doxygen[-nodot(-),dot(+)]
	)
	nls? ( sys-devel/gettext )
	${RDEPEND}"

pkg_pretend() {
	if use openmp && ! tc-has-openmp; then
		eerror "You are using gcc built without 'openmp' USE."
		eerror "Switch CXX to an OpenMP capable compiler."
		die "Need openmp"
	fi

	if use doc; then
		CHECKREQS_DISK_BUILD="4G" check-reqs_pkg_pretend
	fi
}

pkg_setup() {
	python_set_active_version 3
}

src_prepare() {
	epatch "${WORKDIR}"/${PV}/*.patch

	# remove some bundled deps
	rm -r \
		extern/libopenjpeg \
		extern/glew \
		extern/Eigen3 \
		extern/bullet2 \
		extern/colamd \
		extern/binreloc \
		extern/libmv/third_party/{ldl,glog,gflags} \
		|| die

	ewarn "$(echo "Remaining bundled dependencies:";
			( find extern -mindepth 1 -maxdepth 1 -type d; find extern/libmv/third_party -mindepth 1 -maxdepth 1 -type d; ) | sed 's|^|- |')"
}

src_configure() {
	# FIX: forcing '-funsigned-char' fixes an anti-aliasing issue with menu
	# shadows, see bug #276338 for reference
	append-flags -funsigned-char
	append-lfs-flags

	local mycflags=$(printf "'%s'," ${CPPFLAGS} ${CFLAGS} | sed -e 's:,$::')
	local mycxxflags=$(printf "'%s'," ${CPPFLAGS} ${CXXFLAGS} | sed -e 's:,$::')
	local myldflags=$(printf "'%s'," ${LDFLAGS} | sed -e 's:,$::')
	cat << EOF >> "${S}"/user-config.py
CC="$(tc-getCC)"
CXX="$(tc-getCXX)"
CFLAGS=[${mycflags}]
CXXFLAGS=[${mycxxflags}]
BGE_CXXFLAGS=[${mycxxflags}]
LINKFLAGS=[${myldflags}]
PLATFORM_LINKFLAGS=[${myldflags}]
CCFLAGS=[]
REL_CFLAGS=[]
REL_CXXFLAGS=[]
REL_CCFLAGS=[]
C_WARN=[]
CC_WARN=[]
CXX_WARN=[]

BF_OPENJPEG="/usr"
BF_OPENJPEG_INC="/usr/include"
BF_OPENJPEG_LIB="openjpeg"

WITH_BF_BULLET=1
BF_BULLET="/usr/include"
BF_BULLET_INC="/usr/include/bullet /usr/include/bullet/BulletCollision /usr/include/bullet/BulletDynamics /usr/include/bullet/LinearMath /usr/include/bullet/BulletSoftBody"
BF_BULLET_LIB="BulletSoftBody BulletDynamics BulletCollision LinearMath"

WITH_BF_COLAMD=1
BF_COLAMD="/usr"
BF_COLAMD_INC="/usr/include"
BF_COLAMD_LIB="colamd"

BF_OPENCOLLADA_INC="/usr/include/opencollada/"
BF_OPENCOLLADA_LIBPATH="/usr/$(get_libdir)/opencollada/"

BF_OIIO="/usr"
BF_OIIO_INC="/usr/include"
BF_OIIO_LIB="OpenImageIO"

BF_BOOST="/usr"
BF_BOOST_INC="/usr/include/boost"

BF_ICONV="/usr"

BF_TWEAK_MODE=$(usex tweak-mode 1 0)
BF_DEBUG=$(usex debug 1 0)

BF_OPENGL_LIB='GL GLU X11 Xi GLEW'
BF_INSTALLDIR="../install"
WITH_PYTHON_SECURITY=1
WITHOUT_BF_PYTHON_INSTALL=1
BF_PYTHON="/usr"
BF_PYTHON_VERSION="3.2"
BF_PYTHON_ABI_FLAGS=""
BF_BUILDINFO=0
BF_QUIET=0
BF_LINE_OVERWRITE=0
WITH_BF_FHS=1
WITH_BF_BINRELOC=0
WITH_BF_STATICOPENGL=0
EOF

	blend_with() {
		echo "WITH_BF_${2:-$1}=$(usex $1 1 0)" | tr '[:lower:]' '[:upper:]' \
			>> "${S}"/user-config.py
	}

	# configure WITH_BF* Scons build options
	blend_with 3dmouse
	blend_with collada
	blend_with cycles boost
	blend_with cycles oiio
	blend_with cycles
	blend_with dds
	blend_with doc docs
	blend_with elbeem fluid
	blend_with ffmpeg ogg
	blend_with ffmpeg
	blend_with fftw fftw3
	blend_with fftw oceansim
	blend_with game-engine gameengine
	blend_with iconv
	blend_with jack
	blend_with jpeg2k openjpeg
	blend_with nls international
	blend_with openal
	blend_with openexr
	blend_with openmp
	blend_with player
	blend_with redcode
	blend_with sdl
	blend_with sndfile
	blend_with sse rayoptimization
}

src_compile() {
	escons

	cat - > "${T}"/${PN}.env <<EOF
BLENDER_SYSTEM_SCRIPTS="/usr/share/blender/scripts"
BLENDER_SYSTEM_DATAFILES="/usr/share/blender/datafiles"
BLENDER_SYSTEM_PLUGINS="/usr/$(get_libdir)/plugins"
EOF

	if use doc; then
		einfo "Generating Blender C/C++ API docs ..."
		cd "${S}"/doc/doxygen
		doxygen -u Doxyfile
		doxygen || die "doxygen failed to build API docs."

		cd "${S}"
		einfo "Generating (BPY) Blender Python API docs ..."
		"${WORKDIR}"/install/blender --background --python doc/python_api/sphinx_doc_gen.py -noaudio || die "blender failed."

		cd "${S}"/doc/python_api
		sphinx-build sphinx-in BPY_API || die "sphinx failed."
	fi
}

src_test() { :; }

src_install() {
	# Pax mark blender for hardened support.
	pax-mark m "${WORKDIR}/install/blender"

	newenvd "${T}"/${PN}.env 60${PN}

	# install binaries
	dobin "${WORKDIR}/install/blender"
	use player && newbin "${WORKDIR}/install/blenderplayer" blenderplayer

	# install desktop file and icons
	domenu release/freedesktop/blender.desktop
	insinto /usr/share/icons/hicolor
	doins -r release/freedesktop/icons/{*x*,scalable}

	# install docs
	doman "${WORKDIR}"/${P}/doc/manpage/blender.1
	dodoc -r "${WORKDIR}"/${P}/doc/guides/*

	if use doc; then
		docinto "API/python"
		dohtml -r "${S}"/doc/python_api/BPY_API/*

		docinto "API/blender"
		dohtml -r "${S}"/doc/doxygen/html/*
	fi

	# final cleanup
	rm -r "${WORKDIR}"/install/{Python-license.txt,icons,GPL-license.txt,copyright.txt}
	if ! use nls; then
		rm -r "${WORKDIR}/install/${PV/a}/datafiles/locale"
	else
		for x in "${WORKDIR}"/install/${PV/a}/datafiles/locale/* ; do
			mylang=${x##*/}
			use linguas_${mylang} || rm -r ${x}
		done
	fi

	# installing blender
	insinto /usr/share/${PN}
	doins -r "${WORKDIR}"/install/${PV/a}/*
}

pkg_postinst() {
	elog
	elog "Blender uses python integration. As such, may have some"
	elog "inherit risks with running unknown python scripting."
	elog
	elog "It is recommended to change your blender temp directory"
	elog "from /tmp to /home/user/tmp or another tmp file under your"
	elog "home directory. This can be done by starting blender, then"
	elog "dragging the main menu down do display all paths."
	elog
	ewarn "If you're updating from blender before 2.63a, please make"
	ewarn "sure to log out and then back in before launching it, so"
	ewarn "that the new environment variables are picked up."
}
