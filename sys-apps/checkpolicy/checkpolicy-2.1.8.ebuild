# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/checkpolicy/checkpolicy-2.1.8.ebuild,v 1.2 2012/04/29 10:08:55 swift Exp $

inherit toolchain-funcs

SEPOL_VER="2.1.4"
SEMNG_VER="2.1.6"

DESCRIPTION="SELinux policy compiler"
HOMEPAGE="http://userspace.selinuxproject.org"
SRC_URI="http://userspace.selinuxproject.org/releases/20120216/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="debug"

DEPEND=">=sys-libs/libsepol-${SEPOL_VER}
	>=sys-libs/libsemanage-${SEMNG_VER}
	sys-devel/flex
	sys-devel/bison"

RDEPEND=">=sys-libs/libsemanage-${SEMNG_VER}"

src_compile() {
	emake CC="$(tc-getCC)" YACC="bison -y" || die
}

src_install() {
	emake DESTDIR="${D}" install || die

	if use debug; then
		dobin "${S}/test/dismod"
		dobin "${S}/test/dispol"
	fi
}

pkg_postinst() {
	einfo "This checkpolicy can compile version `checkpolicy -V |cut -f 1 -d ' '` policy."
}
