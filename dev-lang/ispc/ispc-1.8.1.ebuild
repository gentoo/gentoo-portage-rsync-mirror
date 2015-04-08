# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/ispc/ispc-1.8.1.ebuild,v 1.1 2015/01/13 02:06:59 ottxor Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7} )

inherit toolchain-funcs python-any-r1

DESCRIPTION="Intel SPMD Program Compiler"
HOMEPAGE="http://ispc.github.com/"

if [[ ${PV} = *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="git://github.com/ispc/ispc.git"
	KEYWORDS=""
else
	SRC_URI="https://github.com/${PN}/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="BSD BSD-2 UoI-NCSA"
SLOT="0"
IUSE="examples"

RDEPEND="
	>=sys-devel/clang-3.0
	>=sys-devel/llvm-3.0
	"
DEPEND="
	${RDEPEND}
	${PYTHON_DEPS}
	sys-devel/bison
	sys-devel/flex
	"

src_compile() {
	sed -i '/^\t@/s/@//' Makefile || die #make all slient commands ("@") verbose
	emake LDFLAGS="${LDFLAGS}" OPT="${CXXFLAGS}" CXX="$(tc-getCXX)" CPP="$(tc-getCPP)"
}

src_install() {
	dobin ispc
	dodoc README.rst

	if use examples; then
		insinto "/usr/share/doc/${PF}/examples"
		docompress -x "/usr/share/doc/${PF}/examples"
		doins -r examples/*
	fi
}
