# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/seqan/seqan-1.4.2.ebuild,v 1.1 2014/10/17 13:51:56 jlec Exp $

EAPI=5

PYTHON_COMPAT=( python2_7 )

inherit cmake-utils flag-o-matic python-single-r1

DESCRIPTION="C++ Sequence Analysis Library"
HOMEPAGE="http://www.seqan.de/"
SRC_URI="http://packages.${PN}.de/${PN}-src/${PN}-src-${PV}.tar.gz"

SLOT="0"
LICENSE="BSD GPL-3"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE=""

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="${PYTHON_DEPS}
	sci-biology/samtools"
DEPEND="${RDEPEND}"

#S="${WORKDIR}"/${P}/cmake

PATCHES=(
	"${FILESDIR}"/${P}-shared.patch
	"${FILESDIR}"/${P}-include.patch
)

src_prepare() {
	rm -f \
		util/cmake/FindZLIB.cmake \
		|| die
	touch extras/apps/seqan_flexbar/README || die
	sed \
		-e "s:share/doc:share/doc/${PF}:g" \
		-i docs/CMakeLists.txt util/cmake/SeqAnBuildSystem.cmake || die
	cmake-utils_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DZLIB_INCLUDE_DIRS="${EPREFIX}"/usr/include
	)
	cmake-utils_src_configure
}

src_install() {
	mkdir -p "${BUILD_DIR}"/docs/html || die
	cmake-utils_src_install
	chmod 755 "${ED}"/usr/bin/*sh || die
}
