# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/stockfish/stockfish-6.ebuild,v 1.1 2015/02/05 20:09:33 yngwin Exp $

EAPI=5
inherit toolchain-funcs

DESCRIPTION="The strongest chess engine in the world"
HOMEPAGE="http://stockfishchess.org/"
SRC_URI="https://stockfish.s3.amazonaws.com/${P}-src.zip"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="cpu_flags_x86_avx2 cpu_flags_x86_popcnt cpu_flags_x86_sse"

DEPEND=""
RDEPEND=""

S=${WORKDIR}/${P}-src/src

src_prepare() {
	sed -e 's:-strip $(BINDIR)/$(EXE)::' -i Makefile
}

src_compile() {
	local my_arch
	use x86 && my_arch=x86-32-old
	use cpu_flags_x86_sse && my_arch=x86-32
	use amd64 && my_arch=x86-64
	use cpu_flags_x86_popcnt && my_arch=x86-64-modern
	use cpu_flags_x86_avx2 && my_arch=x86-64-bmi2

	emake build ARCH=${my_arch} CXX="$(tc-getCXX)" CXXFLAGS="${CXXFLAGS}"
}

src_install() {
	emake PREFIX="${D}/usr" install
	dodoc ../AUTHORS ../Readme.md
}
