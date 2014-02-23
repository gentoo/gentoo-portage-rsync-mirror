# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-physics/lhapdf/lhapdf-6.0.5.ebuild,v 1.1 2014/02/23 02:16:37 bicatali Exp $

EAPI=5

AUTOTOOLS_IN_SOURCE_BUILD=yes
PYTHON_COMPAT=( python{2_6,2_7,3_2,3_3} )

inherit versionator autotools-utils distutils-r1

MY_PV=$(get_version_component_range 1-3 ${PV})
MY_PF=LHAPDF-${MY_PV}

DESCRIPTION="Les Houches Parton Density Function unified library"
HOMEPAGE="http://projects.hepforge.org/lhapdf/"
SRC_URI="http://www.hepforge.org/archive/lhapdf/${MY_PF}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"

IUSE="doc examples python static-libs"
REQUIRED_USE="python? ( ${PYTHON_REQUIRED_USE} )"

RDEPEND="
	dev-libs/boost
	dev-cpp/yaml-cpp
	python? ( ${PYTHON_DEPS} )"
DEPEND="${RDEPEND}
	doc? ( app-doc/doxygen[latex] )"

S="${WORKDIR}/${MY_PF}"

src_configure() {
	autotools-utils_src_configure $(use_enable python)
	if use python; then
		cd "${S}/wrappers/python" && distutils-r1_src_prepare
	fi
}

src_compile() {
	autotools-utils_src_compile all $(use doc && echo doxy)
	if use python; then
	   cd "${S}/wrappers/python" && distutils-r1_src_compile
	fi
}

src_test() {
	autotools-utils_src_compile -C tests
}

src_install() {
	autotools-utils_src_install
	use doc && dohtml -r doc/doxygen/*
	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		doins examples/*.cc
	fi
	if use python; then
	   cd "${S}/wrappers/python" && distutils-r1_src_install
	fi
}

pkg_postinst() {
	elog "To install data files, download them into ${EROOT%/}/usr/share/LHAPDF:"
	elog "http://www.hepforge.org/archive/${PN}/pdfsets/${PV}"
}
