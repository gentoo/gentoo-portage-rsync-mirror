# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/dtc/dtc-1.4.1.ebuild,v 1.3 2015/03/03 09:48:46 dlan Exp $

EAPI="4"

inherit multilib toolchain-funcs
if [[ ${PV} == "9999" ]] ; then
	EGIT_REPO_URI="git://git.kernel.org/pub/scm/utils/dtc/dtc.git"
	inherit git-2
else
	SRC_URI="mirror://kernel/software/utils/${PN}/${P}.tar.xz"
	KEYWORDS="~amd64 ~arm ~arm64 ~ppc ~ppc64 ~x86"
fi

DESCRIPTION="Open Firmware device tree compiler"
HOMEPAGE="http://devicetree.org/Device_Tree_Compiler"

LICENSE="GPL-2"
SLOT="0"
IUSE="static-libs"

RDEPEND=""
DEPEND="app-arch/xz-utils
	sys-devel/flex
	sys-devel/bison"

src_prepare() {
	sed -i \
		-e '/^CFLAGS =/s:=:+=:' \
		-e '/^CPPFLAGS =/s:=:+=:' \
		-e 's:-Werror::' \
		-e 's:-g -Os::' \
		-e "/^PREFIX =/s:=.*:= ${EPREFIX}/usr:" \
		-e "/^LIBDIR =/s:=.*:= \$(PREFIX)/$(get_libdir):" \
		Makefile || die
	tc-export AR CC
	export V=1
}

src_test() {
	emake check
}

src_install() {
	emake DESTDIR="${D}" install
	use static-libs || find "${ED}" -name '*.a' -delete
	dodoc Documentation/manual.txt
}
