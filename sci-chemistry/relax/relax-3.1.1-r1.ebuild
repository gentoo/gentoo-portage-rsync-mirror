# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/relax/relax-3.1.1-r1.ebuild,v 1.1 2013/12/11 10:05:58 jlec Exp $

EAPI=5

PYTHON_COMPAT=( python2_7 )

WX_GTK_VER="2.9"

inherit eutils multiprocessing python-single-r1 scons-utils toolchain-funcs wxwidgets virtualx

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
	x11-libs/wxGTK:${WX_GTK_VER}[X]"
DEPEND="${RDEPEND}
	media-gfx/pngcrush"

pkg_setup() {
	python-single-r1_pkg_setup
}

fix_png() {
	pngcrush -q -fix -force ${1} ${1}-fixed &>/dev/null || die
	mv ${1}-fixed ${1} || die
	echo -e ".\c"
}
src_prepare() {
	local png
	rm -rf minfx bmrblib || die
	epatch \
		"${FILESDIR}"/${PN}-3.0.1-gentoo.patch
	tc-export CC

	ebegin "Fixing png files"
	multijob_init
	for png in $(find -type f -name "*.png"); do
		multijob_child_init fix_png ${png}
	done
	multijob_finish
	eend
}

src_compile() {
	escons
}

src_test() {
	VIRTUALX_COMMAND="${EPYTHON}"
	virtualmake ./${PN}.py -x || die
}

src_install() {
	dodoc README docs/{CHANGES,COMMITTERS,JOBS,relax.pdf,prompt_screenshot.txt}

	python_moduleinto ${PN}
	python_domodule *

	rm ${PN} README || die

	make_wrapper ${PN}-nmr "${EPYTHON} $(python_get_sitedir)/${PN}/${PN}.py $@"
}
