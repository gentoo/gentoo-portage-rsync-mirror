# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/pymol-plugins-promol/pymol-plugins-promol-3.0.2.ebuild,v 1.4 2013/01/22 19:11:15 jlec Exp $

EAPI="3"

PYTHON_DEPEND="2:2.5"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.4 3.*"

inherit python

DESCRIPTION="Fast and accurate regognition of active sites"
HOMEPAGE="http://www.rit.edu/cos/ezviz/ProMOL_dl.html"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux"
LICENSE="as-is"
IUSE=""

RDEPEND="
	dev-python/pmw:0
	sci-chemistry/pymol"
DEPEND=""

src_prepare() {
	python_copy_sources
	preparation() {
		sed -e "s:./modules/pmg_tk/startup:${EPREFIX}/$(python_get_sitedir)/pmg_tk/startup/ProMol:g" -i ProMOL_302.py
	}
	python_execute_function -s preparation
}

src_install(){
	installation() {
		insinto $(python_get_sitedir)/pmg_tk/startup/ProMol/
		doins -r PDB_List AminoPics Motifs *GIF pdb_entry_type.txt Master.txt Scripts || die
		insinto $(python_get_sitedir)/pmg_tk/startup/
		doins *.py || die
		dosym ../../../../../../share/doc/${PF}/html/Help \
			$(python_get_sitedir)/pmg_tk/startup/ProMol/Help || die
		dosym ../../../../../../share/doc/${PF}/html/Thanks.html \
			$(python_get_sitedir)/pmg_tk/startup/ProMol/Thanks.html || die
		dosym ../../../../../../share/doc/${PF}/html/EDMHelp.htm \
			$(python_get_sitedir)/pmg_tk/startup/ProMol/EDMHelp.htm || die
	}
	python_execute_function -s installation

	dodoc *doc || die
	dohtml -r Thanks.html EDMHelp.htm Help
}

pkg_postinst(){
	python_mod_optimize pmg_tk/startup/
}

pkg_postrm() {
	python_mod_cleanup pmg_tk/startup/
}
