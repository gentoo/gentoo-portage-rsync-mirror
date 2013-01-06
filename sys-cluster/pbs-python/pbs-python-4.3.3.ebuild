# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/pbs-python/pbs-python-4.3.3.ebuild,v 1.1 2012/11/08 15:43:51 jlec Exp $

EAPI=5

PYTHON_DEPEND="2"
PYTHON_MODNAME="pbs"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"
DISTUTILS_USE_SEPARATE_SOURCE_DIRECTORIES=1

inherit distutils

MY_P=${P/-/_}

DESCRIPTION="Python bindings to the Torque C API"
HOMEPAGE="https://subtrac.sara.nl/oss/pbs_python/"
SRC_URI="ftp://ftp.sara.nl/pub/outgoing/${MY_P}.tar.gz"

SLOT="0"
LICENSE="openpbs"
KEYWORDS="~amd64 ~x86"
IUSE="examples"

RDEPEND="sys-cluster/torque"
DEPEND="${RDEPEND}"

S=${WORKDIR}/${MY_P}

#pkg_setup() {
#	python_set_active_version 2
#	python_pkg_setup
#}

src_configure() {
	configure() {
		econf
	}
	python_execute_function -s configure
}

src_install() {
	distutils_src_install
	if use examples; then
		insinto /usr/share/doc/${P}
		doins "${S}"/examples/*
	fi
}
