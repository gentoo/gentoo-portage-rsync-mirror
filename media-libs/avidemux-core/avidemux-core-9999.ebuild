# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/avidemux-core/avidemux-core-9999.ebuild,v 1.1 2013/07/16 19:41:10 tomwij Exp $

EAPI="5"

inherit cmake-utils eutils flag-o-matic

SLOT="2.6"

DESCRIPTION="Core libraries for a video editor designed for simple cutting, filtering and encoding tasks."
HOMEPAGE="http://fixounet.free.fr/avidemux"

# Multiple licenses because of all the bundled stuff.
LICENSE="GPL-1 GPL-2 MIT PSF-2 public-domain"
IUSE="debug nls sdl system-ffmpeg vdpau xv"
KEYWORDS="~amd64 ~x86"

MY_PN="${PN/-core/}"
if [[ ${PV} == *9999* ]] ; then
	KEYWORDS=""
	EGIT_REPO_URI="git://gitorious.org/${MY_PN}2-6/${MY_PN}2-6.git https://git.gitorious.org/${MY_PN}2-6/${MY_PN}2-6.git"

	inherit git-2
else
	MY_P="${MY_PN}_${PV}"
	SRC_URI="mirror://sourceforge/${MY_PN}/${PV}/${MY_P}.tar.gz"
fi

# Trying to use virtual; ffmpeg misses aac,cpudetection USE flags now though, are they needed?
DEPEND="
	!<media-video/avidemux-${PV}
	dev-db/sqlite:3
	nls? ( sys-devel/gettext:0 )
	sdl? ( media-libs/libsdl:0 )
	system-ffmpeg? ( >=virtual/ffmpeg-9[mp3,theora] )
	xv? ( x11-libs/libXv:0 )
	vdpau? ( x11-libs/libvdpau:0 )
"
RDEPEND="
	$DEPEND
"
DEPEND="
	$DEPEND
	virtual/pkgconfig:0
	!system-ffmpeg? ( dev-lang/yasm:0[nls=] )
"

S="${WORKDIR}/${MY_P}"
BUILD_DIR="${S}/buildCore"

DOCS=( AUTHORS README )

src_prepare() {
	mkdir "${BUILD_DIR}" || die "Can't create build folder."

	cmake-utils_src_prepare

	if use system-ffmpeg ; then
		# Preparations to support the system ffmpeg. Currently fails because it depends on files the system ffmpeg doesn't install.
		local error="Failed to remove ffmpeg."

		rm -rf cmake/admFFmpeg* cmake/ffmpeg* avidemux_core/ffmpeg_package buildCore/ffmpeg || die "${error}"
		sed -i -e 's/include(admFFmpegUtil)//g' avidemux/commonCmakeApplication.cmake || die "${error}"
		sed -i -e '/registerFFmpeg/d' avidemux/commonCmakeApplication.cmake || die "${error}"
		sed -i -e 's/include(admFFmpegBuild)//g' avidemux_core/CMakeLists.txt || die "${error}"
	else
		# Avoid existing avidemux installations from making the build process fail, bug #461496.
		sed -i -e "s:getFfmpegLibNames(\"\${sourceDir}\"):getFfmpegLibNames(\"${S}/buildCore/ffmpeg/source/\"):g" cmake/admFFmpegUtil.cmake \
			|| die "Failed to avoid existing avidemux installation from making the build fail."
	fi

	# Add lax vector typing for PowerPC.
	if use ppc || use ppc64 ; then
		append-cflags -flax-vector-conversions
	fi

	# See bug 432322.
	use x86 && replace-flags -O0 -O1
}

src_configure() {
	local mycmakeargs="
		-DAVIDEMUX_SOURCE_DIR='${S}'
		$(cmake-utils_use nls GETTEXT)
		$(cmake-utils_use sdl SDL)
		$(cmake-utils_use vdpau VDPAU)
		$(cmake-utils_use xv XVIDEO)
	"

	if use debug ; then
		mycmakeargs+=" -DVERBOSE=1 -DCMAKE_BUILD_TYPE=Debug -DADM_DEBUG=1"
	fi

	CMAKE_USE_DIR="${S}"/avidemux_core cmake-utils_src_configure
}

src_compile() {
	cmake-utils_src_compile -j1
}

src_install() {
	cmake-utils_src_install -j1
}
