# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/libcxxrt/libcxxrt-0.0_p20130531.ebuild,v 1.1 2013/05/31 15:54:41 aballier Exp $

EAPI=4

EGIT_REPO_URI="git://github.com/pathscale/libcxxrt.git"

[ "${PV%9999}" != "${PV}" ] && SCM="git-2" || SCM=""

inherit base flag-o-matic toolchain-funcs portability ${SCM}

DESCRIPTION="C++ Runtime from PathScale, FreeBSD and NetBSD."
HOMEPAGE="https://github.com/pathscale/libcxxrt http://www.pathscale.com/node/265"
if [ "${PV%9999}" = "${PV}" ] ; then
	SRC_URI="mirror://gentoo/${P}.tar.xz"
	DEPEND="app-arch/xz-utils"
else
	SRC_URI=""
fi

LICENSE="BSD-2"
SLOT="0"
if [ "${PV%9999}" = "${PV}" ] ; then
	KEYWORDS="~amd64 ~x86 ~amd64-fbsd ~amd64-linux ~x86-linux"
else
	KEYWORDS=""
fi
IUSE="static-libs"

RDEPEND=">=sys-libs/libunwind-1.0.1-r1[static-libs?]"
DEPEND="${RDEPEND}
	${DEPEND}"

src_prepare() {
	base_src_prepare
	cp "${FILESDIR}/Makefile" src/ || die
	cp "${FILESDIR}/Makefile.test" test/Makefile || die
}

src_compile() {
	# Notes: we build -nodefaultlibs to avoid linking to gcc libs.
	# libcxxrt needs: dladdr (dlopen_lib), libunwind (or libgcc_s but we build
	# over libunwind) and the libc.
	tc-export CC CXX AR
	append-ldflags "-Wl,-z,defs" # make sure we are not underlinked
	cd "${S}/src"
	LIBS="$(dlopen_lib) -lunwind -lc" emake shared
	use static-libs && emake static
}

src_test() {
	cd "${S}/test"
	LD_LIBRARY_PATH="${S}/src:${LD_LIBRARY_PATH}" LIBS="-L${S}/src -lcxxrt -lc" emake check
}

src_install() {
	# TODO: See README. Maybe hide it in a subdir and let only libcxx know about
	# it. FreeBSD head installs it in /lib
	dolib.so src/${PN}.so*
	use static-libs && dolib.a src/${PN}.a

	insinto /usr/include/libcxxrt/
	doins src/cxxabi.h src/unwind*.h

	dodoc AUTHORS COPYRIGHT README
}
