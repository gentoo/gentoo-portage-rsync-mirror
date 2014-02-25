# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/proot/proot-3.2.2.ebuild,v 1.1 2014/02/25 08:15:17 patrick Exp $

EAPI=5
MY_PN="PRoot"

inherit eutils pax-utils toolchain-funcs

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

src_prepare() {
	epatch  "${FILESDIR}/${PN}-3.2.1-makefile.patch" \
		"${FILESDIR}/${PN}-2.3.1-lib-paths-fix.patch"
	epatch_user
}

src_compile() {
	emake -C src V=1 \
		CC="$(tc-getCC)" \
		CHECK_VERSION="true"
}

src_install() {
	# Workaround for bug #493416
	pax-mark -Emp src/proot

	dobin src/proot
	doman doc/proot.1
	dodoc doc/*.txt doc/articles/*
}

src_test() {
	emake -C tests -j1 CC="$(tc-getCC)"
}
