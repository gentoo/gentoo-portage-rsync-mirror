# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/pdb2pqr/pdb2pqr-1.8.0-r1.ebuild,v 1.1 2014/10/24 12:06:42 jlec Exp $

EAPI=5

PYTHON_COMPAT=( python2_7 )

inherit autotools eutils fortran-2 flag-o-matic python-single-r1 toolchain-funcs versionator

MY_PV=$(get_version_component_range 1-2)
MY_P="${PN}-${MY_PV}"

DESCRIPTION="An automated pipeline for performing Poisson-Boltzmann electrostatics calculations"
LICENSE="BSD"
HOMEPAGE="http://www.poissonboltzmann.org/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

SLOT="0"
IUSE="doc examples opal +pdb2pka"
KEYWORDS="~amd64 ~ppc ~x86 ~amd64-linux ~x86-linux"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="${PYTHON_DEPS}
	dev-python/numpy[${PYTHON_USEDEP}]
	sci-chemistry/openbabel[python]
	opal? ( dev-python/zsi[${PYTHON_USEDEP}] )
	pdb2pka? ( sci-chemistry/apbs[${PYTHON_USEDEP},-mpi] )"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${MY_P}"

pkg_setup() {
	if [[ -z ${MAXATOMS} ]]; then
		einfo "If you like to have support for more then 10000 atoms,"
		einfo "export MAXATOMS=\"your value\""
	else
		einfo "Allow usage of ${MAXATOMS} during calculations"
	fi
	fortran-2_pkg_setup
	python-single-r1_pkg_setup
}

src_prepare() {
	rm -rf contrib/* || die
	epatch \
		"${FILESDIR}"/${P}-ldflags.patch \
		"${FILESDIR}"/${PN}-1.4.0-automagic.patch \
		"${FILESDIR}"/1.7.0-install.patch
	sed \
		-e '50,200s:CWD:DESTDIR:g' \
		-i Makefile.am || die

	eautoreconf

	tc-export CC
}

src_configure() {
	# we need to compile the *.so as pic
	append-flags -fPIC
	FFLAGS="${FFLAGS} -fPIC"
	econf \
		--with-max-atoms=${MAXATOMS:-10000} \
		--with-python="${PYTHON}" \
		$(usex pdb2pka "" --disable-pdb2pka) \
		$(use_with opal) \
		NUMPY="${EPREFIX}/$(python_get_sitedir)" \
		F77="$(tc-getFC)"
}

src_compile() {
	default
	if use doc; then
		pushd doc > /dev/null
		sh genpydoc.sh || die "genpydoc failed"
		popd > /dev/null
	fi
}

src_test() {
	emake -j1 test
}

src_install() {
	local lib
	dodir $(python_get_sitedir)/${PN}
	emake -j1 \
		DESTDIR="${ED}$(python_get_sitedir)/${PN}" \
		PREFIX="" install
		INPATH="$(python_get_sitedir)/${PN}"

	make_wrapper ${PN} "${PYTHON} /$(python_get_sitedir)/${PN}/${PN}.py"
	make_wrapper pdb2pka "${PYTHON} /$(python_get_sitedir)/${PN}/pdb2pka/pka.py"

	for lib in _apbs.so apbslib.py{,c,o}; do
		dosym /usr/share/apbs/tools/python/${lib} $(python_get_sitedir)/${PN}/pdb2pka/${lib}
	done

	if use doc; then
		pushd doc > /dev/null
		dohtml -r *.html images pydoc
		popd > /dev/null
	fi

	use examples && \
		insinto /usr/share/${PN}/ && \
		doins -r examples

	dodoc ChangeLog NEWS README AUTHORS

	python_optimize
}
