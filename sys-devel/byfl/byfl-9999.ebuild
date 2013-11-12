# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/byfl/byfl-9999.ebuild,v 1.3 2013/11/12 16:12:07 ottxor Exp $

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

RDEPEND=">=sys-devel/dragonegg-9999
	>=sys-devel/llvm-9999
	>=sys-devel/clang-9999"
DEPEND="${RDEPEND}"

src_prepare() {
	ln -s autoconf/configure.ac || die
	eaclocal -I autoconf/m4
	eautoconf
	replace-flags -O? -O0 #upstream is working on this
}

src_configure() {
	local myeconfargs=(
		--enable-cxx11
	)
	autotools-utils_src_configure DRAGONEGG=/usr/$(get_libdir)/llvm/dragonegg.so
	MAKEOPTS+=" VERBOSE=1 LOPT=$(type -p opt)"
}
