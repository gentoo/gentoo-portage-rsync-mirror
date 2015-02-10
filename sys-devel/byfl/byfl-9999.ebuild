# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/byfl/byfl-9999.ebuild,v 1.9 2015/02/10 22:07:53 ottxor Exp $

EAPI=5

inherit autotools-utils flag-o-matic

if [ "${PV}" = "9999" ]; then
	EGIT_REPO_URI="git://github.com/losalamos/${PN^b}.git http://github.com/losalamos/${PN}.git"
	inherit git-2
	KEYWORDS=""
	AUTOTOOLS_AUTORECONF=1
	LLVM_VERSION="9999"
else
	LLVM_VERSION="3.5.1"
	MY_P="${P}-llvm-${LLVM_VERSION}"
	SRC_URI="https://github.com/losalamos/Byfl/releases/download/v${MY_P#${PN}-}/${MY_P}.tar.gz"
	KEYWORDS="~amd64 ~amd64-linux"
fi

DESCRIPTION="Compiler-based Application Analysis"
HOMEPAGE="https://github.com/losalamos/Byfl"

SLOT="0"
LICENSE="BSD"
IUSE="hdf5"

RDEPEND="~sys-devel/dragonegg-${LLVM_VERSION}
	~sys-devel/clang-${LLVM_VERSION}
	~sys-devel/llvm-${LLVM_VERSION}
	dev-lang/perl:=
	dev-perl/Switch
	hdf5? ( sci-libs/hdf5 )"
DEPEND="${RDEPEND}"

src_configure() {
	append-cxxflags -std=c++11
	autotools-utils_src_configure H5CXX=$(usex hdf5 h5c++ no)
}
