# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/pdb-tools/pdb-tools-0.1.4-r3.ebuild,v 1.2 2012/10/19 10:11:54 jlec Exp $

EAPI=3

PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit fortran-2 python toolchain-funcs

DESCRIPTION="Tools for manipulating and doing calculations on wwPDB macromolecule structure files"
HOMEPAGE="http://code.google.com/p/pdb-tools/"
SRC_URI="http://${PN}.googlecode.com/files/${PN}_${PV}.tar.gz"

SLOT="0"
LICENSE="GPL-3"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE=""

RDEPEND="sci-chemistry/dssp"
DEPEND=""

S="${WORKDIR}"/${PN}_${PV}

pkg_setup() {
	fortran-2_pkg_setup
	python_pkg_setup
}

src_prepare() {
	sed "s:script_dir,\"pdb_data\":\"${EPREFIX}/usr/share/${PN}\",\"pdb_data\":g" -i pdb_sasa.py || die
	sed "/satk_path =/s:^.*$:satk_path = \"${EPREFIX}/usr/bin\":g" -i pdb_satk.py || die
}

src_compile() {
	mkdir bin
	cd satk
	for i in *.f; do
		einfo "$(tc-getFC) ${FFLAGS} ${LDFLAGS} ${i} -o ${i/.f}"
		$(tc-getFC) ${FFLAGS} -c ${i} -o ${i/.f/.o} || die
		$(tc-getFC) ${LDFLAGS} -o ../bin/${i/.f} ${i/.f/.o} || die
		sed "s:${i/.f}.out:${i/.f}:g" -i ../pdb_satk.py || die
	done
}

src_install() {
	insinto /usr/share/${PN}
	doins -r pdb_data/peptides || die
	rm -rf pdb_data/peptides || die

	installation() {
		insinto $(python_get_sitedir)
		doins -r helper pdb_data || die

		insinto $(python_get_sitedir)/${PN}
		doins *.py || die

		for i in pdb_*.py; do
			cat > ${i/.py} <<- EOF
			#!${EPREFIX}/bin/bash
			$(PYTHON) -O "${EPREFIX}$(python_get_sitedir)/${PN}/${i}" \$@
			EOF
			dobin ${i/.py}
		done
	}

	python_execute_function installation

	dobin bin/* || die
	dodoc README || die
}

pkg_postinst() {
	python_mod_optimize ${PN} helper pdb_data
}

pkg_postrm() {
	python_mod_cleanup ${PN} helper pdb_data
}
