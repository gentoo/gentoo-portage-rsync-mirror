# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/hugin/hugin-2013.0.0-r1.ebuild,v 1.9 2015/01/05 10:17:27 pinkbyte Exp $

EAPI=5

WX_GTK_VER="2.8"
PYTHON_COMPAT=( python{2_7,3_2,3_3} )

inherit base python-single-r1 wxwidgets versionator cmake-utils

DESCRIPTION="GUI for the creation & processing of panoramic images"
HOMEPAGE="http://hugin.sf.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2 SIFT"
SLOT="0"
KEYWORDS="amd64 ~ppc ~x86"

LANGS=" bg ca cs da de en_GB es eu fi fr hu it ja ko nl pl pt_BR ro ru sk sl sv uk zh_CN zh_TW"
IUSE="lapack python sift debug $(echo ${LANGS//\ /\ linguas_})"

CDEPEND="
	!!dev-util/cocom
	app-arch/zip
	dev-cpp/tclap
	<dev-libs/boost-1.54.0:=
	dev-libs/zthread
	>=media-gfx/enblend-4.0
	media-gfx/exiv2:=
	media-libs/freeglut
	media-libs/glew:=
	media-libs/lensfun
	>=media-libs/libpano13-2.9.18:0=
	media-libs/libpng:0=
	media-libs/openexr:=
	media-libs/tiff
	sys-libs/zlib
	virtual/jpeg
	x11-libs/wxGTK:2.8=[X,opengl,-odbc]
	lapack? ( virtual/lapack )
	sift? ( media-gfx/autopano-sift-C )"
RDEPEND="${CDEPEND}
	media-libs/exiftool"
DEPEND="${CDEPEND}
	sys-devel/gettext
	virtual/pkgconfig
	python? ( ${PYTHON_DEPS} >=dev-lang/swig-2.0.4 )"

REQUIRED_USE="python? ( ${PYTHON_REQUIRED_USE} )"

S=${WORKDIR}/${PN}-$(get_version_component_range 1-3)

PATCHES=( "${FILESDIR}"/${P}-boost.patch )

pkg_setup() {
	DOCS="authors.txt README TODO"
	mycmakeargs=(
		$(cmake-utils_use_enable lapack LAPACK)
		$(cmake-utils_use_build python HSI)
	)
	python-single-r1_pkg_setup
}

src_prepare() {
	sed \
		-e 's:-O3::g' \
		-i src/celeste/CMakeLists.txt || die
	rm CMakeModules/{FindLAPACK,FindPkgConfig}.cmake || die

	cmake-utils_src_prepare
}

src_install() {
	cmake-utils_src_install
	python_optimize

	for lang in ${LANGS} ; do
		case ${lang} in
			ca) dir=ca_ES;;
			cs) dir=cs_CZ;;
			*) dir=${lang};;
		esac
		use linguas_${lang} || rm -r "${D}"/usr/share/locale/${dir}
	done
}
