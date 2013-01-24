# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/sudsds/sudsds-1.0.1.ebuild,v 1.3 2013/01/24 14:06:13 idella4 Exp $

EAPI="4"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils

DESCRIPTION="Lightweight SOAP client - Czech NIC labs fork"
HOMEPAGE="https://labs.nic.cz/page/969/"
SRC_URI="http://www.nic.cz/public_media/datove_schranky/releases/src/${P}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="doc"

DEPEND="dev-python/setuptools
	doc? ( dev-python/epydoc )"
RDEPEND=""

src_compile() {
	distutils_src_compile

	buildDocs() {
		PYTHONPATH=$(ls -d build-${PYTHON_ABI}/lib/) \
			epydoc -n "Sudsds - ${DESCRIPTION}" -o doc ${PN} || die "Generation of documentation failed"
	}

	if use doc; then
		einfo "Generation of documentation"
		python_execute_function -f buildDocs
	fi
}

src_install() {
	distutils_src_install

	use doc && dohtml -r doc/
}
