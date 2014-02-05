# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/graph-tool/graph-tool-2.2.29.ebuild,v 1.1 2014/02/05 19:51:32 radhermit Exp $

EAPI=5
PYTHON_COMPAT=( python{2_7,3_2,3_3} )

inherit check-reqs eutils toolchain-funcs python-r1

if [[ ${PV} == "9999" ]] ; then
	EGIT_REPO_URI="git://git.skewed.de/graph-tool"
	inherit git-2
else
	SRC_URI="http://downloads.skewed.de/${PN}/${P}.tar.bz2"
	KEYWORDS="~amd64 ~x86"
fi

DESCRIPTION="An efficient python module for manipulation and statistical analysis of graphs"
HOMEPAGE="http://graph-tool.skewed.de/"

LICENSE="GPL-3"
SLOT="0"
IUSE="+cairo openmp"

CDEPEND="${PYTHON_DEPS}
	>=dev-libs/boost-1.46.0[python,${PYTHON_USEDEP}]
	dev-libs/expat
	dev-python/numpy[${PYTHON_USEDEP}]
	sci-libs/scipy[${PYTHON_USEDEP}]
	>=sci-mathematics/cgal-3.5
	cairo? (
		dev-cpp/cairomm
		dev-python/pycairo[${PYTHON_USEDEP}]
	)"
RDEPEND="${CDEPEND}
	dev-python/matplotlib[${PYTHON_USEDEP}]"
DEPEND="${CDEPEND}
	dev-cpp/sparsehash
	virtual/pkgconfig"

# most machines don't have enough ram for parallel builds
MAKEOPTS="${MAKEOPTS} -j1"

# bug 453544
CHECKREQS_DISK_BUILD="6G"

pkg_pretend() {
	if use openmp ; then
		tc-has-openmp || die "Please switch to an openmp compatible compiler"
	fi
	check-reqs_pkg_pretend
}

src_prepare() {
	>py-compile
	python_copy_sources
}

src_configure() {
	python_parallel_foreach_impl run_in_build_dir \
		econf \
			--disable-static \
			--disable-optimization \
			$(use_enable openmp) \
			$(use_enable cairo)
}

src_compile() {
	python_parallel_foreach_impl run_in_build_dir default
}

src_install() {
	python_parallel_foreach_impl run_in_build_dir default
	prune_libtool_files --modules

	# remove unwanted extra docs
	rm -r "${ED}"/usr/share/doc/${PN} || die
}

run_in_build_dir() {
	pushd "${BUILD_DIR}" > /dev/null
	"$@"
	popd > /dev/null
}
