# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/byfl/byfl-9999.ebuild,v 1.4 2014/01/15 22:12:48 ottxor Exp $

EAPI=5

inherit autotools-utils flag-o-matic multilib

if [ "${PV}" = "9999" ]; then
	EGIT_REPO_URI="git://github.com/losalamos/${PN^b}.git http://github.com/losalamos/${PN}.git"
	inherit git-2
	KEYWORDS=""
else
	SRC_URI="https://github.com/losalamos/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

DESCRIPTION="Compiler-based Application Analysis"
HOMEPAGE="https://github.com/losalamos/Byfl"

SLOT="0"
LICENSE="BSD"
IUSE=""

RDEPEND=">=sys-devel/dragonegg-3.4
	>=sys-devel/llvm-3.4
	>=sys-devel/clang-3.4"
DEPEND="${RDEPEND}"

src_prepare() {
	ln -s autoconf/configure.ac || die
	eaclocal -I autoconf/m4
	eautoconf
	replace-flags -O? -O0 #http://llvm.org/bugs/show_bug.cgi?id=18358
}

src_configure() {
	local myeconfargs=(
		--enable-cxx11
	)
	autotools-utils_src_configure DRAGONEGG=/usr/$(get_libdir)/dragonegg.so
	MAKEOPTS+=" VERBOSE=1 LOPT=$(type -p opt)"
}
