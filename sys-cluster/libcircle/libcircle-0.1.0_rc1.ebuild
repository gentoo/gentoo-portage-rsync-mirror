# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/libcircle/libcircle-0.1.0_rc1.ebuild,v 1.3 2014/01/19 19:27:26 ottxor Exp $

EAPI=5

inherit autotools-utils

if [ "${PV}" = "9999" ]; then
	EGIT_REPO_URI="git://github.com/hpc/${PN}.git http://github.com/hpc/${PN}.git"
	inherit git-2
	KEYWORDS=""
else
	[[ ${PV} = *rc* ]] && MY_PV="${PV%%_rc*}-rc.${PV#*_rc}" || MY_PV="${PV}"
	inherit vcs-snapshot
	SRC_URI="https://github.com/hpc/${PN}/archive/v${MY_PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

DESCRIPTION="an API for distributing embarrassingly parallel workloads using self-stabilization"
HOMEPAGE="https://github.com/hpc/libcircle"

SLOT="0"
LICENSE="BSD"
IUSE="doc test"

RDEPEND="virtual/mpi"
DEPEND="${RDEPEND}
	doc? ( app-doc/doxygen )
	test? ( dev-libs/check )"

PATCHES=( "${FILESDIR}/${P}-out-of-source.patch" )
AUTOTOOLS_AUTORECONF=1
DOCS=( HACKING.md README.md )

src_configure() {
	local myeconfargs=(
		$(usex test '--enable-tests' '')
		$(usex doc '--enable-doxygen' '')
	)
	autotools-utils_src_configure
}

src_install() {
	use doc && HTML_DOCS=( "${BUILD_DIR}/doc/html/" )
	autotools-utils_src_install
}
