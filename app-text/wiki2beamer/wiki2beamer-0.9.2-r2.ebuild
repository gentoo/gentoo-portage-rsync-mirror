# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/wiki2beamer/wiki2beamer-0.9.2-r2.ebuild,v 1.2 2011/06/30 00:11:37 sping Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit python

DESCRIPTION="Tool to produce LaTeX Beamer code from wiki-like input."

HOMEPAGE="http://wiki2beamer.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.zip"

LICENSE="|| ( GPL-2 GPL-3 ) FDL-1.3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+examples"

DEPEND="app-arch/unzip"
RDEPEND=""

src_install() {
	if use examples; then
		# Patch example Makefile
		sed -e 's|../../code/wiki2beamer|wiki2beamer|' \
				-i doc/example/Makefile \
				|| die

		insinto /usr/share/doc/${PF}/example
		doins doc/example/* || die
	fi

	doman doc/man/${PN}.1 || die
	dodoc ChangeLog README || die

	per_abi_install() {
		local MAIN_DIR="$(python_get_sitedir)"/${PN}
		insinto "${MAIN_DIR}"
		newins code/${PN} ${PN}.py || die

		fperms 755 "${MAIN_DIR}"/${PN}.py || die
		dosym "${MAIN_DIR}"/${PN}.py /usr/bin/${PN}-${PYTHON_ABI} || die
	}
	python_execute_function per_abi_install

	python_generate_wrapper_scripts "${ED}usr/bin/${PN}"
}

pkg_postinst() {
	python_mod_optimize ${PN}
}

pkg_postrm() {
	python_mod_cleanup ${PN}
}
