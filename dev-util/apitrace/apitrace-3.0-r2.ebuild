# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/apitrace/apitrace-3.0-r2.ebuild,v 1.1 2014/03/21 22:15:40 vapier Exp $

EAPI="5"
PYTHON_COMPAT=( python{2_6,2_7} )

inherit cmake-utils eutils python-any-r1 multilib vcs-snapshot

DESCRIPTION="A tool for tracing, analyzing, and debugging graphics APIs"
HOMEPAGE="https://github.com/apitrace/apitrace"
SRC_URI="https://github.com/${PN}/${PN}/tarball/${PV} -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE="egl multilib qt4"

RDEPEND="app-arch/snappy
	media-libs/libpng:0=
	sys-libs/zlib
	media-libs/mesa[egl?]
	egl? ( || (
		>=media-libs/mesa-8.0[gles1,gles2]
		<media-libs/mesa-8.0[gles]
	) )
	x11-libs/libX11
	multilib? ( app-emulation/emul-linux-x86-baselibs )
	qt4? (
		>=dev-qt/qtcore-4.7:4
		>=dev-qt/qtgui-4.7:4
		>=dev-qt/qtwebkit-4.7:4
		>=dev-libs/qjson-0.5
	)"
DEPEND="${RDEPEND}
	${PYTHON_DEPS}"

EMULTILIB_PKG="true"

PATCHES=(
	"${FILESDIR}"/${P}-system-libs.patch
	"${FILESDIR}"/${P}-glxtrace-only.patch
	"${FILESDIR}"/${PN}-3.0-gcc47.patch
	"${FILESDIR}"/${P}-memcpy.patch
)

src_prepare() {
	cmake-utils_src_prepare

	# Workaround NULL DT_RPATH issues
	sed -i -e "s/install (TARGETS/#\0/" gui/CMakeLists.txt || die
}

src_configure() {
	for ABI in $(get_install_abis) ; do
		mycmakeargs=(
			$(cmake-utils_use_enable qt4 GUI)
			$(cmake-utils_use_enable egl EGL)
		)

		if use multilib ; then
			if [[ "${ABI}" != "${DEFAULT_ABI}" ]] ; then
				mycmakeargs=(
					-DBUILD_LIB_ONLY=ON
					-DENABLE_GUI=OFF
					$(cmake-utils_use_enable egl EGL)
				)
			fi
			multilib_toolchain_setup ${ABI}
		fi

		BUILD_DIR="${WORKDIR}/${P}_build-${ABI}"
		cmake-utils_src_configure
	done
}

src_compile() {
	for ABI in $(get_install_abis) ; do
		use multilib && multilib_toolchain_setup ${ABI}
		BUILD_DIR="${WORKDIR}/${P}_build-${ABI}"
		cmake-utils_src_compile
	done
}

src_install() {
	dobin "${BUILD_DIR}"/{glretrace,apitrace}
	use qt4 && dobin "${BUILD_DIR}"/qapitrace

	for ABI in $(get_install_abis) ; do
		BUILD_DIR="${WORKDIR}/${P}_build-${ABI}"
		exeinto /usr/$(get_libdir)/${PN}/wrappers
		doexe "${BUILD_DIR}"/wrappers/*.so
		dosym glxtrace.so /usr/$(get_libdir)/${PN}/wrappers/libGL.so
		dosym glxtrace.so /usr/$(get_libdir)/${PN}/wrappers/libGL.so.1
		dosym glxtrace.so /usr/$(get_libdir)/${PN}/wrappers/libGL.so.1.2
	done

	dodoc {BUGS,DEVELOPMENT,NEWS,README,TODO}.markdown

	exeinto /usr/$(get_libdir)/${PN}/scripts
	doexe $(find scripts -type f -executable)
}
