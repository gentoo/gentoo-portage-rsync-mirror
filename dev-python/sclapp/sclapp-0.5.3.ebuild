# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/sclapp/sclapp-0.5.3.ebuild,v 1.5 2014/09/18 17:36:15 sping Exp $

EAPI="2"
SUPPORT_PYTHON_ABIS="1"

inherit eutils distutils

DESCRIPTION="Framework for writing simple command-line applications"
HOMEPAGE="http://forestbond.com/media/docs/${P}.html"
SRC_URI="http://www.alittletooquiet.net/media/release/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/pexpect"
RDEPEND="${DEPEND}"
RESTRICT_PYTHON_ABIS="3.*"

src_prepare() {
	epatch "${FILESDIR}/${P}-testsuite-fix-from-r235.patch"
}

src_test() {
	testing() {
		PYTHONPATH="build-${PYTHON_ABI}/lib" "$(PYTHON)" setup.py build -b "build-${PYTHON_ABI}" test
	}
	python_execute_function testing
}
