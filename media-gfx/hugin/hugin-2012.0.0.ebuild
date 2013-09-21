# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/hugin/hugin-2012.0.0.ebuild,v 1.4 2013/09/21 13:30:27 ago Exp $

EAPI=3
WX_GTK_VER="2.8"
PYTHON_DEPEND="python? 2:2.6 3"

inherit base python wxwidgets versionator cmake-utils

DESCRIPTION="GUI for the creation & processing of panoramic images"
HOMEPAGE="http://hugin.sf.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
LICENSE="GPL-2 SIFT"
SLOT="0"
KEYWORDS="amd64 ~ppc ~x86"

LANGS=" bg ca cs da de en_GB es fi fr hu it ja ko nl pl pt_BR ro ru sk sl sv uk zh_CN zh_TW"
IUSE="lapack python sift $(echo ${LANGS//\ /\ linguas_})"

CDEPEND="
	!!dev-util/cocom
	app-arch/zip
	dev-cpp/tclap
	>=dev-libs/boost-1.49.0-r1
	dev-libs/zthread
	>=media-gfx/enblend-4.0
	media-gfx/exiv2
	media-libs/freeglut
	media-libs/glew
	media-libs/lensfun
	>=media-libs/libpano13-2.9.18
	media-libs/libpng
	media-libs/openexr
	media-libs/tiff
	sys-libs/zlib
	virtual/jpeg
	x11-libs/wxGTK:2.8[X,opengl,-odbc]
	lapack? ( virtual/lapack )
	sift? ( media-gfx/autopano-sift-C )"
RDEPEND="${CDEPEND}
	media-libs/exiftool"
DEPEND="${CDEPEND}
	virtual/pkgconfig
	python? ( >=dev-lang/swig-2.0.4 )"

S=${WORKDIR}/${PN}-$(get_version_component_range 1-3)

pkg_setup() {
	DOCS="authors.txt README TODO"
	mycmakeargs=(
		$(cmake-utils_use_enable lapack LAPACK)
		$(cmake-utils_use_build python HSI)
	)
}

src_install() {
	cmake-utils_src_install

	for lang in ${LANGS} ; do
		case ${lang} in
			ca) dir=ca_ES;;
			cs) dir=cs_CZ;;
			*) dir=${lang};;
		esac
		use linguas_${lang} || rm -r "${D}"/usr/share/locale/${dir}
	done
}
