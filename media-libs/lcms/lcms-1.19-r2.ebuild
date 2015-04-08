# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/lcms/lcms-1.19-r2.ebuild,v 1.5 2015/04/08 17:59:35 mgorny Exp $

EAPI="5"

PYTHON_COMPAT=( python{2_7,3_3,3_4} )

# autoreconf needs to update python macros for py3 support.
AUTOTOOLS_AUTORECONF=1

inherit autotools-multilib python-r1

DESCRIPTION="A lightweight, speed optimized color management engine"
HOMEPAGE="http://www.littlecms.com/"
SRC_URI="http://www.littlecms.com/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc x86 ~amd64-fbsd ~sparc-fbsd ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~m68k-mint ~sparc-solaris ~x64-solaris ~x86-solaris"
IUSE="jpeg python static-libs tiff zlib"

RDEPEND="
	tiff? ( >=media-libs/tiff-4.0.3-r6:0[${MULTILIB_USEDEP}] )
	jpeg? ( >=virtual/jpeg-0-r2:0[${MULTILIB_USEDEP}] )
	zlib? ( >=sys-libs/zlib-1.2.8-r1[${MULTILIB_USEDEP}] )
	python? ( ${PYTHON_DEPS} )
	abi_x86_32? (
		!<=app-emulation/emul-linux-x86-baselibs-20140508-r11
		!app-emulation/emul-linux-x86-baselibs[-abi_x86_32(-)]
	)
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

multilib_src_configure() {
	local myeconfargs=(
		$(use_enable static-libs static)
		$(use_with jpeg)
		$(use_with tiff)
		$(use_with zlib)
	)
	autotools-utils_src_configure --without-python

	if multilib_is_native_abi && use python; then
		python_parallel_foreach_impl \
			autotools-utils_src_configure --with-python
	fi
}

multilib_src_compile() {
	default

	if multilib_is_native_abi && use python; then
		# Note: it intentionally passes evaluated 'parent' dir.
		python_parallel_foreach_impl \
			autotools-utils_src_compile -C python \
			top_builddir="${BUILD_DIR}"
	fi
}

multilib_src_test() {
	cp "${S}"/testbed/*icm testbed/ || die

	default
}

multilib_src_install() {
	emake DESTDIR="${ED}" BINDIR="${ED}"/usr/bin install

	if multilib_is_native_abi && use python; then
		# Note: it intentionally passes evaluated 'parent' dir.
		python_foreach_impl \
			autotools-utils_src_install -C python \
			top_builddir="${BUILD_DIR}"

		python_parallel_foreach_impl python_optimize
	fi

	insinto /usr/share/lcms/profiles
	doins "${S}"/testbed/*.icm
}

multilib_src_install_all() {
	DOCS=( AUTHORS README.1ST INSTALL NEWS doc/{LCMSAPI,TUTORIAL}.TXT )

	einstalldocs
	prune_libtool_files --modules
}
