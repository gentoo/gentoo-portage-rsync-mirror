# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/relax/relax-2.1.0.ebuild,v 1.2 2013/11/16 08:25:43 dirtyepic Exp $

EAPI=4

PYTHON_DEPEND="2"

WX_GTK_VER="2.8"

inherit eutils python scons-utils toolchain-funcs wxwidgets

DESCRIPTION="Molecular dynamics by NMR data analysis"
HOMEPAGE="http://www.nmr-relax.com/"
SRC_URI="http://download.gna.org/relax/${P}.src.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE=""

RDEPEND="
	dev-python/numpy
	sci-libs/bmrblib
	sci-libs/minfx
	sci-libs/scipy
	x11-libs/wxGTK:2.8[X]"
DEPEND="${RDEPEND}"

pkg_setup() {
	python_pkg_setup
	python_set_active_version 2
}

src_prepare() {
	rm -rf minfx bmrblib
	epatch "${FILESDIR}"/${P}-gentoo.patch
	tc-export CC
}

src_compile() {
	escons
}

src_test() {
	$(PYTHON) ./${PN}.py -s || die
	$(PYTHON) ./${PN}.py -x || die
}

src_install() {
	dodoc README
	rm ${PN} README || doe

	insinto $(python_get_sitedir)/${PN}
	doins -r *

	make_wrapper ${PN} "$(PYTHON) $(python_get_sitedir)/${PN}/${PN}.py $@"
}
