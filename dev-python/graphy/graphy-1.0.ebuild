# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/graphy/graphy-1.0.ebuild,v 1.2 2009/12/24 15:37:30 arfrever Exp $

EAPI="2"
SUPPORT_PYTHON_ABIS="1"

inherit python

MY_P=${PN}_${PV}

DESCRIPTION="Simple Chart Library for Python"
HOMEPAGE="http://code.google.com/p/graphy/"
SRC_URI="http://${PN}.googlecode.com/files/${MY_P}.tar.bz2"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="examples"

DEPEND=""
RDEPEND=""
RESTRICT_PYTHON_ABIS="3.*"

S=${WORKDIR}/${MY_P}

src_prepare() {
	python_convert_shebangs -r 2 .
}

src_test() {
	testing() {
		PYTHONPATH=. "$(PYTHON)" ${PN}/all_tests.py
	}
	python_execute_function testing
}

src_install() {
	# we don't want to install tests, removing them
	rm ${PN}/*_test.py ${PN}/all_tests.py || die "rm failed"

	# installing everything
	installation() {
		insinto $(python_get_sitedir)/${PN}
		doins ${PN}/*.py || die "doins failed"
		insinto $(python_get_sitedir)/${PN}/backends
		doins ${PN}/backends/*.py || die "doins failed"
		insinto $(python_get_sitedir)/${PN}/backends/google_chart_api
		doins ${PN}/backends/google_chart_api/*.py || die "doins failed"
	}
	python_execute_function installation

	dodoc README || die "dodoc failed"

	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		doins examples/*.py || die "doins failed"
	fi
}

pkg_postinst() {
	python_mod_optimize ${PN}
}

pkg_postrm() {
	python_mod_cleanup ${PN}
}
