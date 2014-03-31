# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/inotifyx/inotifyx-0.2.0-r1.ebuild,v 1.3 2014/03/31 21:17:55 mgorny Exp $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7} pypy pypy2_0 )

inherit distutils-r1

DESCRIPTION="Python bindings to the Linux inotify file system event monitoring API"
HOMEPAGE="http://www.alittletooquiet.net/software/inotifyx/"
SRC_URI="http://launchpad.net/inotifyx/dev/v${PV}/+download/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

DEPEND=""
RDEPEND=""

python_prepare_all() {
	use test && DISTUTILS_NO_PARALLEL_BUILD=1
}

python_test() {
	"${PYTHON}" setup.py build -b "build-${EPYTHON}" test || die "Tests failed under ${EPYTHON}"
}
