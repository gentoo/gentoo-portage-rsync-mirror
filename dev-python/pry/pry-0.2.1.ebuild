# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pry/pry-0.2.1.ebuild,v 1.1 2012/10/30 08:06:38 radhermit Exp $

EAPI="5"

PYTHON_DEPEND="2:2.5"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"
PYTHON_MODNAME="libpry"

inherit distutils eutils

DESCRIPTION="A unit testing framework and coverage engine"
HOMEPAGE="https://github.com/cortesi/pry http://pypi.python.org/pypi/pry/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

RDEPEND="!dev-ruby/pry"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-0.2.1-exit-status.patch
}

src_test() {
	cd test
	testing() {
		PYTHONPATH="../build-${PYTHON_ABI}/lib" "$(PYTHON)" \
			../build-${PYTHON_ABI}/scripts-${PYTHON_ABI}/pry
	}
	python_execute_function testing
}

src_install() {
	distutils_src_install
	use doc && dohtml -r doc/*
}
