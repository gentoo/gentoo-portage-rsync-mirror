# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/systemtap/systemtap-1.7.ebuild,v 1.4 2012/12/15 19:34:20 tetromino Exp $

EAPI=4

PYTHON_DEPEND="2"

inherit linux-info autotools python

DESCRIPTION="A linux trace/probe tool"
HOMEPAGE="http://sourceware.org/systemtap/"
SRC_URI="http://sources.redhat.com/${PN}/ftp/releases/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~mips ~ppc ~ppc64 ~x86"
IUSE="sqlite"

DEPEND=">=dev-libs/elfutils-0.142
	sys-libs/libcap
	sqlite? ( dev-db/sqlite:3 )"
RDEPEND="${DEPEND}
	virtual/linux-sources"

CONFIG_CHECK="~KPROBES ~RELAY ~DEBUG_FS"
ERROR_KPROBES="${PN} requires support for KProbes Instrumentation (KPROBES) - this can be enabled in 'Instrumentation Support -> Kprobes'."
ERROR_RELAY="${PN} works with support for user space relay support (RELAY) - this can be enabled in 'General setup -> Kernel->user space relay support (formerly relayfs)'."
ERROR_DEBUG_FS="${PN} works best with support for Debug Filesystem (DEBUG_FS) - this can be enabled in 'Kernel hacking -> Debug Filesystem'."

DOCS="AUTHORS HACKING NEWS README"

pkg_setup() {
	linux-info_pkg_setup
	python_set_active_version 2
	python_pkg_setup
}

src_prepare() {
	python_convert_shebangs 2 dtrace.in

	sed -i \
		-e 's:-Werror::g' \
		configure.ac Makefile.am \
		grapher/Makefile.am \
		runtime/staprun/Makefile.am \
		buildrun.cxx \
		runtime/bench2/bench.rb \
		runtime/bench2/Makefile \
		testsuite/systemtap.unprivileged/unprivileged_probes.exp \
		testsuite/systemtap.unprivileged/unprivileged_myproc.exp \
		testsuite/systemtap.base/stmt_rel_user.exp \
		testsuite/systemtap.base/sdt_va_args.exp \
		testsuite/systemtap.base/sdt_misc.exp \
		testsuite/systemtap.base/sdt.exp \
		scripts/kprobes_test/gen_code.py
	eautoreconf
}

src_configure() {
	econf \
		--docdir="${EPREFIX}/usr/share/doc/${PF}" \
		--without-rpm \
		--disable-server \
		--disable-docs \
		--disable-refdocs \
		--disable-grapher \
		$(use_enable sqlite)
}
