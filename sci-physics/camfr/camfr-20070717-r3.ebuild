# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-physics/camfr/camfr-20070717-r3.ebuild,v 1.5 2013/02/21 22:09:58 jlec Exp $

EAPI=4

PYTHON_DEPEND="2"
PYTHON_USE_WITH="tk"
SUPPORT_PYTHON_ABIS="1"

inherit eutils fortran-2 distutils toolchain-funcs

DISTUTILS_USE_SEPARATE_SOURCE_DIRECTORIES="true"

DESCRIPTION="Full vectorial Maxwell solver based on eigenmode expansion"
HOMEPAGE="http://camfr.sourceforge.net/"
SRC_URI="mirror://sourceforge/camfr/${P}.tgz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE=""

RDEPEND="
	dev-libs/blitz
	>=dev-libs/boost-1.48[python]
	dev-python/imaging[tk]
	dev-python/matplotlib
	sci-libs/scipy
	virtual/lapack"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	dev-util/scons"

RESTRICT_PYTHON_ABIS="3.*"

S="${WORKDIR}/${P/-/_}"

src_prepare() {
	epatch \
		"${FILESDIR}"/${P}-gcc43.patch \
		"${FILESDIR}"/${P}-python.patch

	cp "${FILESDIR}"/machine_cfg.py.gentoo machine_cfg.py || die
	python_copy_sources

	preparation() {
		local libfort lapack_libs lapack_libdirs
		# Configure to compile against selected python version
		cat <<-EOF >> machine_cfg.py
			include_dirs = []
			include_dirs.append("${EPREFIX}/$(python_get_includedir)")
			include_dirs.append("${EPREFIX}/$(python_get_sitedir)")
		EOF
		local x
		for x in $($(tc-getPKG_CONFIG) --libs-only-l lapack); do
			lapack_libs="${lapack_libs}, \"${x#-l}\""
		done
		for x in $($(tc-getPKG_CONFIG) --libs-only-L lapack); do
			lapack_libdirs="${lapack_libdirs}, \"${x#-L}\""
		done
		cat <<-EOF >> machine_cfg.py
			library_dirs = [${lapack_libdirs#,}]
			libs = ["boost_python-${PYTHON_ABI}-mt", "blitz"${lapack_libs}]
		EOF
	}
	python_execute_function -s preparation
}

src_test() {
	testing() {
		# trick to avoid X in testing (bug #229753)
		echo "backend : Agg" > matplotlibrc
		PYTHONPATH=".:visualisation" "$(PYTHON)" testsuite/camfr_test.py
		rm -f matplotlibrc
	}
	python_execute_function -s testing
}

src_install() {
	distutils_src_install
	dodoc docs/camfr.pdf
}
