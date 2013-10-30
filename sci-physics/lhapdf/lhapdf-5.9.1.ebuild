# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-physics/lhapdf/lhapdf-5.9.1.ebuild,v 1.1 2013/10/30 17:16:28 bicatali Exp $

EAPI=5

AUTOTOOLS_IN_SOURCE_BUILD=yes
PYTHON_COMPAT=( python{2_6,2_7} )

inherit versionator autotools-utils python-single-r1

MY_PV=$(get_version_component_range 1-3 ${PV})
MY_PF=${PN}-${MY_PV}

DESCRIPTION="Les Houches Parton Density Function unified library"
HOMEPAGE="http://projects.hepforge.org/lhapdf/"
SRC_URI="http://www.hepforge.org/archive/lhapdf/${MY_PF}.tar.gz
	test? (
		http://www.hepforge.org/archive/${PN}/pdfsets/${MY_PV}/cteq61.LHgrid
		http://www.hepforge.org/archive/${PN}/pdfsets/${MY_PV}/MRST2004nlo.LHgrid
		http://www.hepforge.org/archive/${PN}/pdfsets/${MY_PV}/cteq61.LHpdf
		http://www.hepforge.org/archive/${PN}/pdfsets/${MY_PV}/CT10.LHgrid
		octave? ( http://www.hepforge.org/archive/${PN}/pdfsets/${MY_PV}/cteq5l.LHgrid ) )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="cxx doc examples octave python static-libs test"
REQUIRED_USE="octave? ( cxx ) python? ( ${PYTHON_REQUIRED_USE} )"

RDEPEND="
	octave? ( sci-mathematics/octave )
	python? ( ${PYTHON_DEPS} )"
DEPEND="${RDEPEND}
	doc? ( app-doc/doxygen[latex] )
	python? ( dev-lang/swig )"

S="${WORKDIR}/${MY_PF}"

src_prepare() {
	# do not create extra latex docs
	sed -i \
		-e 's/GENERATE_LATEX.*=YES/GENERATE_LATEX = NO/g' \
		ccwrap/Doxyfile || die
}

src_configure() {
	local myeconfargs=(
		$(use_enable cxx ccwrap)
		$(use_enable cxx old-ccwrap)
		$(use_enable doc doxygen)
		$(use_enable octave)
		$(use_enable python pyext)
	)
	autotools-utils_src_configure
}

src_test() {
	cd "${BUILD_DIR}"
	# need to make a bogus link for octave test
	ln -s "${DISTDIR}" PDFsets
	LHAPATH="${PWD}/PDFsets" \
		LD_LIBRARY_PATH="${PWD}/lib/.libs:${LD_LIBRARY_PATH}" \
		emake check
}

src_install() {
	autotools-utils_src_install
	use python \
		&& python_fix_shebang "${ED}"/usr/bin/lhapdf-{getdata,query}
	use doc && use cxx && dohtml -r ccwrap/doxy/html/*
	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		doins examples/*.{f,cc}
	fi
}

pkg_postinst() {
	elog "To install data files, you have to run as root:"
	elog "lhapdf-getdata --dest=${EROOT%/}/usr/share/lhapdf/PDFsets --all"
}
