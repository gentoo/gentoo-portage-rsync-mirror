# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/relax/relax-2.2.1.ebuild,v 1.2 2013/05/29 16:27:19 jlec Exp $

EAPI=5

PYTHON_COMPAT=( python2_7 )

WX_GTK_VER="2.8"

inherit eutils python-single-r1 scons-utils toolchain-funcs wxwidgets

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
	>=sci-libs/bmrblib-1.0.1_pre198[${PYTHON_USEDEP}]
	>=sci-libs/minfx-1.0.4_pre98[${PYTHON_USEDEP}]
	sci-libs/scipy[${PYTHON_USEDEP}]
	x11-libs/wxGTK:2.8[X]"
DEPEND="${RDEPEND}"

pkg_setup() {
	wxwidgets_pkg_setup
	python-single-r1_pkg_setup
}

src_prepare() {
	rm -rf minfx bmrblib || die
	epatch "${FILESDIR}"/${P}-gentoo.patch
	echo true > devel_scripts/byte_compile || die
	tc-export CC
}

src_compile() {
	escons
}

src_test() {
	${EPYTHON} ./${PN}.py -s || die
	${EPYTHON} ./${PN}.py -x || die
}

src_install() {
	dodoc README
	rm ${PN} README || die

	python_moduleinto ${PN}
	python_domodule *

	make_wrapper ${PN} "${EPYTHON} $(python_get_sitedir)/${PN}/${PN}.py $@"
}
