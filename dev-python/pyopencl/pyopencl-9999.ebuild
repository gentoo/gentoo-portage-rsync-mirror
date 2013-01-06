# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyopencl/pyopencl-9999.ebuild,v 1.14 2012/04/19 07:32:38 xarthisius Exp $

EAPI="4"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* *-jython 2.7-pypy-*"

inherit distutils git-2

EGIT_REPO_URI="http://git.tiker.net/trees/pyopencl.git"

DESCRIPTION="Python wrapper for OpenCL"
HOMEPAGE="http://mathema.tician.de/software/pyopencl http://pypi.python.org/pypi/pyopencl"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="examples opengl"

RDEPEND=">=dev-libs/boost-1.48[python]
	dev-python/decorator
	dev-python/numpy
	dev-python/mako
	=dev-python/pytools-9999
	>=virtual/opencl-0-r1"
DEPEND="${RDEPEND}"

DISTUTILS_USE_SEPARATE_SOURCE_DIRECTORIES="1"

src_configure()
{
	configuration() {
		local myconf=()

		if use opengl; then
			myconf+=(--cl-enable-gl)
		fi

		"$(PYTHON)" configure.py \
			--boost-compiler=gcc \
			--boost-python-libname=boost_python-${PYTHON_ABI}-mt \
			--no-use-shipped-boost \
			"${myconf[@]}"
	}
	python_execute_function -s configuration
}

src_install()
{
	distutils_src_install

	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r examples
	fi
}

pkg_postinst()
{
	distutils_pkg_postinst
	if use examples; then
		elog "Some of the examples provided by this package require dev-python/matplotlib."
	fi
}
