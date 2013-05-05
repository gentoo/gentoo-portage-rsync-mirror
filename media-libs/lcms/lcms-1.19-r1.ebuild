# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/lcms/lcms-1.19-r1.ebuild,v 1.1 2013/05/05 21:00:10 dilfridge Exp $

EAPI="5"

PYTHON_COMPAT=( python{2_5,2_6,2_7,3_2,3_3} )

# autoreconf needs to update python macros for py3 support.
AUTOTOOLS_AUTORECONF=1
AUTOTOOLS_PRUNE_LIBTOOL_FILES="modules"

inherit autotools-utils python-r1

DESCRIPTION="A lightweight, speed optimized color management engine"
HOMEPAGE="http://www.littlecms.com/"
SRC_URI="http://www.littlecms.com/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~amd64-fbsd ~sparc-fbsd ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~m68k-mint ~sparc-solaris ~x64-solaris ~x86-solaris"
IUSE="jpeg python static-libs tiff zlib"

RDEPEND="
	tiff? ( media-libs/tiff:0 )
	jpeg? ( virtual/jpeg )
	zlib? ( sys-libs/zlib )
	python? ( ${PYTHON_DEPS} )
"
DEPEND="${RDEPEND}
	python? ( >=dev-lang/swig-1.3.31 )
"

PATCHES=(
	"${FILESDIR}/${P}-disable_static_modules.patch"
	"${FILESDIR}/${P}-implicit.patch"
	"${FILESDIR}/${P}-fix-swig-destructor.patch"
	"${FILESDIR}/${P}-fix-python3.2.patch"
)

DOCS=( AUTHORS README.1ST INSTALL NEWS doc/{LCMSAPI,TUTORIAL}.TXT )

src_prepare() {
	# Breaks out-of-source build, only corresponding .in file is needed
	rm include/icc34.h || die 'rm failed'

	autotools-utils_src_prepare

	# run swig to regenerate lcms_wrap.cxx and lcms.py (bug #148728)
	if use python; then
		cd python || die
		bash swig_lcms || die
	fi
}

src_configure() {
	local myeconfargs=(
		$(use_enable static-libs static)
		$(use_with jpeg)
		$(use_with tiff)
		$(use_with zlib)
	)
	autotools-utils_src_configure --without-python

	if use python; then
		python_parallel_foreach_impl \
			autotools-utils_src_configure --with-python
	fi
}

src_compile() {
	autotools-utils_src_compile

	if use python; then
		# Note: it intentionally passes evaluated 'parent' dir.
		python_parallel_foreach_impl \
			autotools-utils_src_compile -C python \
			top_builddir="${BUILD_DIR}"
	fi
}

src_test() {
	cp "${S}"/testbed/*icm "${BUILD_DIR}"/testbed/ || die

	autotools-utils_src_test
}

src_install() {
	autotools-utils_src_install \
		BINDIR="${ED}"/usr/bin

	if use python; then
		# Note: it intentionally passes evaluated 'parent' dir.
		python_foreach_impl \
			autotools-utils_src_install -C python \
			top_builddir="${BUILD_DIR}"

		python_parallel_foreach_impl python_optimize
	fi

	insinto /usr/share/lcms/profiles
	doins testbed/*.icm
}
