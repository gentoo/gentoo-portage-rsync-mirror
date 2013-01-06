# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/gentoopm/gentoopm-0.2.5-r2.ebuild,v 1.2 2012/10/14 22:54:06 ferringb Exp $

EAPI=4
PYTHON_COMPAT='python2_6 python2_7 python3_1 python3_2'

inherit base python-distutils-ng

DESCRIPTION="A common interface to Gentoo package managers"
HOMEPAGE="https://bitbucket.org/mgorny/gentoopm/"
SRC_URI="mirror://bitbucket/mgorny/${PN}/downloads/${P}.tar.bz2"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="amd64 ~mips x86 ~amd64-fbsd ~x86-fbsd"
IUSE="doc"

RDEPEND="|| ( >=sys-apps/portage-2.1.10.3
		>=sys-apps/pkgcore-0.8
		>=sys-apps/paludis-0.64.2[python-bindings] )"
DEPEND="doc? ( dev-python/epydoc )"
PDEPEND="app-admin/eselect-package-manager"

python_prepare_all() {
	base_src_prepare
}

src_compile() {
	python-distutils-ng_src_compile

	if use doc; then
		"${PYTHON}" setup.py doc || die
	fi
}

python_install_all() {
	if use doc; then
		dohtml -r doc/*
	fi
}
