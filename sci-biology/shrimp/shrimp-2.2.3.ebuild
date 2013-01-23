# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/shrimp/shrimp-2.2.3.ebuild,v 1.2 2013/01/23 10:06:29 patrick Exp $

EAPI=4

PYTHON_DEPEND=2

inherit flag-o-matic python toolchain-funcs

MY_PV=${PV//./_}

DESCRIPTION="SHort Read Mapping Package"
HOMEPAGE="http://compbio.cs.toronto.edu/shrimp/"
SRC_URI="http://compbio.cs.toronto.edu/shrimp/releases/SHRiMP_${MY_PV}.src.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="custom-cflags"

# file collision on /usr/bin/utils #453044
DEPEND="!sci-mathematics/cado-nfs"
RDEPEND="${DEPEND}"

S=${WORKDIR}/SHRiMP_${MY_PV}

pkg_setup() {
	if [[ ${CC} == *gcc* ]] &&	! tc-has-openmp; then
		elog "Please set CC to an OPENMP capable compiler (e.g. gcc[openmp] or icc"
		die "C compiler lacks OPENMP support"
	fi
	python_set_active_version 2
	python_pkg_setup
}

src_prepare() {
	sed -e '1 a #include <stdint.h>' -i common/dag_glue.cpp || die
	# respect LDFLAGS wrt 331823
	sed -i -e "s/LDFLAGS/LIBS/" -e "s/\$(LD)/& \$(LDFLAGS)/" \
		-e 's/-static//' Makefile || die
	python_convert_shebangs -r -- 2 utils
}

src_compile() {
	append-flags -fopenmp
	if ! use custom-cflags; then
		append-flags -O3
		replace-flags -O2 -O3
	fi
	tc-export CXX
	emake CXXFLAGS="${CXXFLAGS}" LDFLAGS="${LDFLAGS}"
}

src_install() {
	local i
	dobin bin/* utils/split-contigs utils/temp-sink
	dodoc HISTORY README TODO SPLITTING_AND_MERGING SCORES_AND_PROBABILITES

	pushd utils > /dev/null
	for i in *py; do
		newbin ${i} ${i%.py}
	done

	rm *.py *.o *.c split-contigs temp-sink || die
	insinto /usr/share/${PN}
	doins -r *
}
