# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/gprof2dot/gprof2dot-0_p20100216.ebuild,v 1.4 2012/03/15 20:16:55 sping Exp $

EAPI="3"
SUPPORT_PYTHON_ABIS="1"
PYTHON_DEPEND="*"
PYTHON_USE_WITH="xml"

inherit eutils python

DESCRIPTION="Converts profiling output to dot graphs"
HOMEPAGE="http://code.google.com/p/jrfonseca/wiki/Gprof2Dot"
SRC_URI="http://www.hartwork.org/public/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

src_prepare() {
	epatch "${FILESDIR}"/${P}-python3.patch
}

src_install() {
	abi_specific_install() {
		local code_dir="$(python_get_sitedir)"/${PN}
		exeinto "${code_dir}"
		doexe ${PN}.py || die "doexe failed"

		dodir /usr/bin
		dosym "${code_dir}"/${PN}.py /usr/bin/${PN}-${PYTHON_ABI} \
			|| die "dosym failed"
	}
	python_execute_function abi_specific_install

	python_generate_wrapper_scripts "${ED}usr/bin/${PN}"
}

pkg_postinst() {
	python_mod_optimize ${PN}
}

pkg_postrm() {
	python_mod_cleanup ${PN}
}
