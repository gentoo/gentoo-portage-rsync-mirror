# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/gs-pypi/gs-pypi-9999.ebuild,v 1.1 2014/08/29 13:11:56 jauhien Exp $

EAPI=5

PYTHON_COMPAT=(python{2_7,3_2,3_3})

inherit distutils-r1 git-2

DESCRIPTION="g-sorcery backend for pypi packages"
HOMEPAGE="https://github.com/jauhien/gs-pypi"
SRC_URI=""
EGIT_BRANCH="master"
EGIT_REPO_URI="http://github.com/jauhien/gs-pypi"

LICENSE="GPL-2"
SLOT="0"

DEPEND="app-portage/g-sorcery
		dev-python/beautifulsoup:4"
RDEPEND="${DEPEND}"

python_install_all() {
	distutils-r1_python_install_all
	doman docs/*.8
}
