# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/linux-headers/linux-headers-3.1.ebuild,v 1.9 2012/05/12 16:14:37 armin76 Exp $

EAPI="3"

ETYPE="headers"
H_SUPPORTEDARCH="alpha amd64 arm bfin cris hppa m68k mips ia64 ppc ppc64 s390 sh sparc x86"
inherit kernel-2
detect_version

PATCH_VER="2"
SRC_URI="mirror://gentoo/gentoo-headers-base-${PV}.tar.xz"
[[ -n ${PATCH_VER} ]] && SRC_URI="${SRC_URI} mirror://gentoo/gentoo-headers-${PV}-${PATCH_VER}.tar.xz"

KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc x86 ~amd64-linux ~x86-linux"

DEPEND="app-arch/xz-utils
	dev-lang/perl"
RDEPEND=""

S=${WORKDIR}/gentoo-headers-base-${PV}

src_unpack() {
	unpack ${A}
}

src_prepare() {
	has x32 $(get_all_abis) || EPATCH_EXCLUDE+=" 90_all_x32-3.1.patch"
	[[ -n ${PATCH_VER} ]] && EPATCH_SUFFIX="patch" epatch "${WORKDIR}"/${PV}
}

src_install() {
	kernel-2_src_install
	cd "${D}"
	egrep -r \
		-e '(^|[[:space:](])(asm|volatile|inline)[[:space:](]' \
		-e '\<([us](8|16|32|64))\>' \
		.
	headers___fix $(find -type f)

	egrep -l -r -e '__[us](8|16|32|64)' "${D}" | xargs grep -L linux/types.h

	# hrm, build system sucks
	find "${D}" '(' -name '.install' -o -name '*.cmd' ')' -print0 | xargs -0 rm -f

	# provided by libdrm (for now?)
	rm -rf "${D}"/$(kernel_header_destdir)/drm
}

src_test() {
	emake ARCH=$(tc-arch-kernel) headers_check || die
}
