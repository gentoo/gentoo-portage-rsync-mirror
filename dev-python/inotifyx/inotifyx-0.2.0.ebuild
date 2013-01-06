# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/inotifyx/inotifyx-0.2.0.ebuild,v 1.2 2012/02/22 02:17:53 patrick Exp $

EAPI="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="*-jython 3.*"

inherit distutils

DESCRIPTION="Python bindings to the Linux inotify file system event monitoring API"
HOMEPAGE="http://www.alittletooquiet.net/software/inotifyx/"
SRC_URI="http://launchpad.net/inotifyx/dev/v${PV}/+download/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

src_test() {
	testing() {
		PYTHONPATH=$(echo "build-${PYTHON_ABI}/lib"*) "$(PYTHON)" setup.py build -b "build-${PYTHON_ABI}" test
	}
	python_execute_function testing
}
