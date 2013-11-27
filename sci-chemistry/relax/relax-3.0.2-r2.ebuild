# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/relax/relax-3.0.2-r2.ebuild,v 1.1 2013/11/27 11:27:08 jlec Exp $

EAPI=5

PYTHON_COMPAT=( python2_7 )

WX_GTK_VER="2.8"

inherit eutils python-single-r1 scons-utils toolchain-funcs wxwidgets virtualx

DESCRIPTION="Molecular dynamics by NMR data analysis"
HOMEPAGE="http://www.nmr-relax.com/"
SRC_URI="http://download.gna.org/relax/${P}.src.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE=""

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="
	${PYTHON_DEPS}
	dev-python/numpy[${PYTHON_USEDEP}]
	dev-python/wxpython:${WX_GTK_VER}[${PYTHON_USEDEP}]
	sci-chemistry/molmol
	sci-chemistry/pymol[${PYTHON_USEDEP}]
	sci-chemistry/vmd
	>=sci-libs/bmrblib-1.0.1_pre198[${PYTHON_USEDEP}]
	>=sci-libs/minfx-1.0.4_pre98[${PYTHON_USEDEP}]
	sci-libs/scipy[${PYTHON_USEDEP}]
	sci-visualization/grace
	sci-visualization/opendx
	x11-libs/wxGTK:2.8[X]"
DEPEND="${RDEPEND}"

pkg_setup() {
	python-single-r1_pkg_setup
}

src_prepare() {
	rm -rf minfx bmrblib || die
	epatch \
		"${FILESDIR}"/${PN}-3.0.1-gentoo.patch \
		"${FILESDIR}"/${P}-wxpython.patch \
		"${FILESDIR}"/${P}-wxpython-2.patch
	tc-export CC
}

src_compile() {
	escons
}

src_test() {
	VIRTUALX_COMMAND="${EPYTHON}"
#	virtualmake ./${PN}.py -x || die
	virtualmake ./${PN}.py --gui-tests || die
}

src_install() {
	dodoc README docs/{CHANGES,COMMITTERS,JOBS,relax.pdf,prompt_screenshot.txt}

	python_moduleinto ${PN}
	python_domodule *

	rm ${PN} README || die

	make_wrapper ${PN}-nmr "${EPYTHON} $(python_get_sitedir)/${PN}/${PN}.py $@"
}
