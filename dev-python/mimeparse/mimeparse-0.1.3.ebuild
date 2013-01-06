# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/mimeparse/mimeparse-0.1.3.ebuild,v 1.2 2012/05/03 15:21:19 floppym Exp $

EAPI=4
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils

DESCRIPTION="Basic functions for handling mime-types in python"
HOMEPAGE="http://code.google.com/p/mimeparse"
SRC_URI="http://mimeparse.googlecode.com/files/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"
PYTHON_MODNAME="mimeparse.py"

RDEPEND=""
DEPEND="${RDEPEND}
	dev-python/setuptools
	test? ( dev-python/simplejson )"

# tests fail for python3
src_test() {
	testing() {
		PYTHONPATH="build-${PYTHON_ABI}/lib/" \
		"$(PYTHON)" mimeparse_test.py
	}
	python_execute_function testing
}
