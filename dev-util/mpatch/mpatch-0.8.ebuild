# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/mpatch/mpatch-0.8.ebuild,v 1.2 2011/04/07 19:25:10 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="2"

inherit distutils

DESCRIPTION="mpatch applies diffs and is generally similar to patch, but it can also help resolve a number of common causes of patch rejects."
HOMEPAGE="http://oss.oracle.com/~mason/mpatch/"
SRC_URI="http://oss.oracle.com/~mason/mpatch/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~ppc"
IUSE=""

DEPEND=""
RDEPEND=""

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_install() {
	distutils_src_install
	dobin cmd/qp cmd/mp || die "dobin failed"
}
