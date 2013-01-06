# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/pymol-plugins-psico/pymol-plugins-psico-3.0.ebuild,v 1.4 2012/11/06 19:10:22 jlec Exp $

EAPI=4

PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"
PYTHON_MODNAME="psico"

inherit distutils vcs-snapshot

DESCRIPTION="Pymol ScrIpt COllection"
HOMEPAGE="https://github.com/speleo3/pymol-psico/"
SRC_URI="https://github.com/speleo3/pymol-psico/tarball/${PV} -> ${P}.tar.gz"

SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
LICENSE="BSD-2"
IUSE="minimal"

RDEPEND="
	dev-python/numpy
	sci-biology/biopython
	sci-libs/mmtk
	!minimal? (
		media-libs/qhull
		media-video/mplayer
		sci-biology/stride
		sci-chemistry/ccp4-apps
		sci-chemistry/dssp
		sci-chemistry/mm-align
		sci-chemistry/pdbmat
		sci-chemistry/theseus
		sci-chemistry/tm-align
		sci-mathematics/diagrtb
	)"

pkg_postinst() {
	if ! use minimal; then
		elog "For full functionality you need to get DynDom from"
		elog "http://fizz.cmp.uea.ac.uk/dyndom/dyndomMain.do"
	fi
}
