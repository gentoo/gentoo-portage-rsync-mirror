# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/proot/proot-2.3.1.ebuild,v 1.1 2013/01/24 08:54:46 pinkbyte Exp $

EAPI=5
MY_PN="PRoot"

inherit base toolchain-funcs

DESCRIPTION="User-space implementation of chroot, mount --bind, and binfmt_misc"
HOMEPAGE="http://proot.me"
SRC_URI="https://github.com/cedric-vincent/${MY_PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="sys-libs/talloc"
DEPEND="${RDEPEND}
	test? ( dev-util/valgrind )"

# Breaks sandbox
RESTRICT="test"

S="${WORKDIR}/${MY_PN}-${PV}"

PATCHES=(
	"${FILESDIR}/${P}-makefile.patch"
	"${FILESDIR}/${P}-gnu-define-fix.patch"
	"${FILESDIR}/${P}-lib-paths-fix.patch"
)

src_compile() {
	# FLAGS come from Makefile.
	emake -C src V=1 \
		CC="$(tc-getCC)" \
		CHECK_VERSION="true"
}

src_install() {
	dobin src/proot
	doman doc/proot.1
	dodoc doc/*.txt doc/articles/*
}

src_test() {
	emake -C tests -j1 CC="$(tc-getCC)"
}
