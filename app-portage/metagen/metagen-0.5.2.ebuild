# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/metagen/metagen-0.5.2.ebuild,v 1.6 2010/08/09 23:20:08 jer Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils

DESCRIPTION="metadata.xml generator for ebuilds"
HOMEPAGE="http://git.overlays.gentoo.org/gitweb/?p=proj/metagen.git;a=summary"
SRC_URI="mirror://gentoo/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 hppa ppc x86"

IUSE=""
DEPEND=">=dev-python/jaxml-3.01"

src_install() {
	distutils_src_install

	metagen_install() {
		local METAGEN_MOD="$(python_get_sitedir)/${PN}/main.py"
		fperms 755 ${METAGEN_MOD}
		dosym  "${D}"${METAGEN_MOD} "/usr/bin/${PN}-${PYTHON_ABI}"
	}
	python_execute_function metagen_install

	python_generate_wrapper_scripts "${ED}usr/bin/${PN}"

	doman "docs/metagen.1"
}

src_test() {
	einfo "Starting tests..."
	testing() {
		$(PYTHON) -c "from metagen import metagenerator; metagenerator.do_tests()"
	}
	python_execute_function testing
	einfo "Tests completed."
}
