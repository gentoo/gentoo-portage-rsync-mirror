# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/pdb2pqr/pdb2pqr-1.9.0.ebuild,v 1.3 2014/10/29 02:42:21 patrick Exp $

EAPI=5

PYTHON_COMPAT=( python2_7 )

inherit scons-utils fortran-2 flag-o-matic python-single-r1 toolchain-funcs

DESCRIPTION="An automated pipeline for performing Poisson-Boltzmann electrostatics calculations"
HOMEPAGE="http://www.poissonboltzmann.org/"
SRC_URI="https://github.com/Electrostatics/apbs-${PN}/releases/download/${P}/${PN}-src-${PV}.tar.gz"

SLOT="0"
LICENSE="BSD"
IUSE="doc examples opal +pdb2pka"
KEYWORDS="~amd64 ~ppc ~x86 ~amd64-linux ~x86-linux"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="${PYTHON_DEPS}
	dev-python/numpy[${PYTHON_USEDEP}]
	sci-chemistry/openbabel[python]
	sci-chemistry/openbabel-python[${PYTHON_USEDEP}]
	opal? ( dev-python/zsi[${PYTHON_USEDEP}] )
	pdb2pka? ( sci-chemistry/apbs[${PYTHON_USEDEP},-mpi] )"
DEPEND="${RDEPEND}
	dev-lang/swig:0"

pkg_setup() {
	if [[ -z ${MAXATOMS} ]]; then
		einfo "If you like to have support for more then 10000 atoms,"
		einfo "export MAXATOMS=\"your value\""
		export MAXATOMS=10000
	else
		einfo "Allow usage of ${MAXATOMS} during calculations"
	fi
	fortran-2_pkg_setup
	python-single-r1_pkg_setup
}

src_prepare() {
	find -type f \( -name "*\.pyc" -o -name "*\.pyo" \) -delete || die

	cat > build_config.py <<- EOF
	PREFIX="${ED}/$(python_get_sitedir)/${PN}"
	#URL="http://<COMPUTER NAME>/pdb2pqr/"
	APBS="${EPREFIX}/usr/bin/apbs"
	#OPAL="http://nbcr-222.ucsd.edu/opal2/services/pdb2pqr_1.8"
	#APBS_OPAL="http://nbcr-222.ucsd.edu/opal2/services/apbs_1.3"
	MAX_ATOMS=${MAXATOMS}
	BUILD_PDB2PKA=$(usex pdb2pka True False)
	REBUILD_SWIG=True
	EOF

	export CXXFLAGS="${CXXFLAGS}"
	export LDFLAGS="${LDFLAGS}"

	epatch "${FILESDIR}"/${P}-flags.patch
	tc-export CXX
	rm -rf scons || die
}

src_compile() {
	escons
}

src_test() {
	local myesconsargs=( -j1 )
	escons test
	escons advtest
	escons complete-test
}

src_install() {
	escons install

	local lib

	make_wrapper ${PN} "${PYTHON} /$(python_get_sitedir)/${PN}/${PN}.py"
	make_wrapper pdb2pka "${PYTHON} /$(python_get_sitedir)/${PN}/pdb2pka/pka.py"

	for lib in apbslib.py{,c,o}; do
		dosym ../../apbs/${lib} $(python_get_sitedir)/${PN}/pdb2pka/${lib}
	done
	dosym ../../_apbslib.so $(python_get_sitedir)/${PN}/pdb2pka/_apbslib.so

	if use doc; then
		pushd doc > /dev/null
		dohtml -r *.html images pydoc
		popd > /dev/null
	fi

	use examples && \
		insinto /usr/share/${PN}/ && \
		doins -r examples

	dodir /usr/share/doc/${PF}/html
	mv "${ED}"$(python_get_sitedir)/${PN}/doc/pydoc/* "${ED}"/usr/share/doc/${PF}/html || die
	rmdir "${ED}"$(python_get_sitedir)/${PN}/doc/pydoc || die
	mv "${ED}"$(python_get_sitedir)/${PN}/doc/* "${ED}"/usr/share/doc/${PF}/ || die

	dodoc *md NEWS

	find "${ED}"$(python_get_sitedir)/${PN}/contrib -delete || die

	python_optimize
}
