# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyfits/pyfits-3.2.3.ebuild,v 1.1 2014/05/28 16:22:34 bicatali Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7,3_2,3_3} )
inherit distutils-r1 eutils multilib

DESCRIPTION="Provides an interface to FITS formatted files under python"
HOMEPAGE="http://www.stsci.edu/resources/software_hardware/pyfits"
SRC_URI="mirror://pypi/p/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~x86-fbsd ~amd64-linux ~x86-linux"
IUSE="doc test"

RDEPEND="
	dev-python/numpy[${PYTHON_USEDEP}]
	!<dev-python/astropy-0.3
	sci-libs/cfitsio:0="
DEPEND="${RDEPEND}
	>=dev-python/d2to1-0.2.5[${PYTHON_USEDEP}]
	dev-python/setuptools[${PYTHON_USEDEP}]
	>=dev-python/stsci-distutils-0.3[${PYTHON_USEDEP}]
	doc? (
			dev-python/matplotlib
			dev-python/numpydoc
			dev-python/sphinxcontrib-programoutput
			dev-python/stsci-sphinxext
		 )
	test? ( dev-python/nose[${PYTHON_USEDEP}] )"

PATCHES=( "${FILESDIR}"/${PN}-3.2.1-unbundle-cfitsio.patch )

python_prepare_all() {
	sed -i \
		-e "s/\(hook_package_dir = \)lib/\1$(get_libdir)/g" \
		"${S}"/setup.cfg || die
	distutils-r1_python_prepare_all
}

python_compile_all() {
	use doc && emake -C docs html
}

python_test() {
	cd "${BUILD_DIR}"/lib* || die
	nosetests || die
}

python_install_all() {
	use doc && local HTML_DOCS=( docs/build/html )
	distutils-r1_python_install_all
	dodoc FAQ.txt CHANGES.txt
	rename_binary() {
		local binary
		for binary in "${ED}"/usr/bin/* "${D}$(python_get_scriptdir)"/*
		do
			mv ${binary}{,-${PN}} || die "failed renaming"
		done
	}
	python_foreach_impl rename_binary
}
