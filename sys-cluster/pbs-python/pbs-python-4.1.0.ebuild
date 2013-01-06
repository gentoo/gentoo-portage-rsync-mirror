# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/pbs-python/pbs-python-4.1.0.ebuild,v 1.2 2010/06/09 14:32:13 arfrever Exp $

EAPI=3
PYTHON_DEPEND="2"
PYTHON_MODNAME="pbs"

inherit distutils

MY_P=${P/-/_}

DESCRIPTION="Python bindings to the Torque C API"
HOMEPAGE="https://subtrac.sara.nl/oss/pbs_python/"
SRC_URI="ftp://ftp.sara.nl/pub/outgoing/${MY_P}.tar.gz"

LICENSE="openpbs"
SLOT="0"
KEYWORDS="~amd64"
IUSE="examples"

RDEPEND="sys-cluster/torque"
DEPEND="${RDEPEND}"

S=${WORKDIR}/${MY_P}

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_install() {
	distutils_src_install
	if use examples; then
		insinto /usr/share/doc/${P}	|| die
		doins "${S}"/examples/*		|| die
	fi
}
