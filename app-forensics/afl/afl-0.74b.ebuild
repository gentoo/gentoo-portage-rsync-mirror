# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-forensics/afl/afl-0.74b.ebuild,v 1.1 2014/11/27 23:00:17 hanno Exp $

EAPI=5
inherit multilib toolchain-funcs

DESCRIPTION="american fuzzy lop - compile-time instrumentation fuzzer"
HOMEPAGE="http://lcamtuf.coredump.cx/afl/"
SRC_URI="http://lcamtuf.coredump.cx/afl/releases//${P}.tgz"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""
DEPEND="sys-devel/gcc"
RDEPEND="${DEPEND}"

src_compile() {
	emake CC="$(tc-getCC)" \
		HELPER_PATH="/usr/$(get_libdir)/afl"
}

src_install() {
	emake DESTDIR="${D}" \
		PREFIX="/usr" \
		HELPER_PATH="/usr/$(get_libdir)/afl" \
		DOC_PATH="/usr/share/doc/${PF}" \
		install
}
