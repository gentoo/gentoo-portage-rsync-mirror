# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/prodecomp/prodecomp-3.0.ebuild,v 1.1 2010/10/20 06:25:57 jlec Exp $

EAPI="3"

PYTHON_DEPEND="2"
PYTHON_USE_WITH="tk"

inherit python

DESCRIPTION="Decomposition-based analysis of NMR projections"
HOMEPAGE="http://www.lundberg.gu.se/nmr/software.php?program=PRODECOMP"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
LICENSE="GPL-2"
IUSE="examples"

RDEPEND="sci-libs/scipy"
DEPEND=""

S="${WORKDIR}"/NMRProjAnalys

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_install() {
	if use examples; then
		insinto /usr/share/${PN}
		doins -r ExampleData Results || die
	fi

	insinto /usr/share/doc/${PF}
	doins ProjTools/Manual.pdf || die
	rm -rf ProjTools/Manual.pdf ProdecompOutput || die

	insinto $(python_get_sitedir)
	doins -r ProjTools || die
	mv "${ED}"/$(python_get_sitedir)/{ProjTools,${PN}} || die

	cat >> "${T}"/${PN} <<- EOF
	#!/bin/bash
	$(PYTHON) -O "${EPREFIX}"/$(python_get_sitedir)/${PN}/ProjAnalys.py $@
	EOF
	dobin "${T}"/${PN} || die

	dosym ../../../../share/doc/${PF}/Manual.pdf $(python_get_sitedir)/${PN}/Manual.pdf
}
