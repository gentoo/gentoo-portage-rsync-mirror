# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/clustershell/clustershell-1.6.ebuild,v 1.3 2013/06/25 12:57:54 ago Exp $

# TODO: test phase

EAPI=5

PYTHON_COMPAT=( python2_5 python2_6 python2_7 )
PYTHON_REQ_USE="xml"
inherit distutils-r1

DESCRIPTION="Python framework for efficient cluster administration"
HOMEPAGE="http://cea-hpc.github.com/clustershell/"
SRC_URI="https://github.com/cea-hpc/clustershell/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="CeCILL-C"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="doc"

RDEPEND="dev-libs/openssl"
DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"

src_install() {
	distutils-r1_src_install

	if use doc ; then
		local i
		for i in $(ls -I man "${S}"/doc) ; do
			dodoc -r doc/${i}
		done
	fi

	doman doc/man/man*/*

	insinto /etc/${PN}
	doins -r conf/*
}

pkg_postinst() {
	einfo
	einfo "Some default system-wide config files have been installed into"
	einfo "/etc/${PN}"
	einfo
}
