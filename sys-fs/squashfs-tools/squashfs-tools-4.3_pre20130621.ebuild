# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/squashfs-tools/squashfs-tools-4.3_pre20130621.ebuild,v 1.1 2014/01/21 10:25:49 jlec Exp $

EAPI=5

inherit eutils toolchain-funcs

DESCRIPTION="Tool for creating compressed filesystem type squashfs"
HOMEPAGE="http://squashfs.sourceforge.net"
SRC_URI="http://dev.gentoo.org/~jlec/distfiles/${P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~arm-linux ~x86-linux"
IUSE="+xz lzma lzo xattr"

RDEPEND="
	sys-libs/zlib
	xz? ( app-arch/xz-utils )
	lzo? ( dev-libs/lzo )
	lzma? ( app-arch/xz-utils )
	!xz? ( !lzo? ( sys-libs/zlib ) )
	xattr? ( sys-apps/attr )"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${P}/squashfs-tools"

use_sed() {
	local u=$1 s="${2:-`echo $1 | tr '[:lower:]' '[:upper:]'`}_SUPPORT"
	printf '/^#?%s =/%s\n' "${s}" \
		"$( use $u && echo s:.*:${s} = 1: || echo d )"
}

_src_prepare() {
	epatch "${WORKDIR}"/${P}.patch
}

src_configure() {
	tc-export CC
	sed -i -r \
		-e "$(use_sed xz XZ)" \
		-e "$(use_sed lzo)" \
		-e "$(use_sed xattr)" \
		-e "$(use_sed lzma LZMA_XZ)" \
		Makefile || die
}

src_install() {
	dobin mksquashfs unsquashfs
	dodoc ../README
}

pkg_postinst() {
	ewarn "This version of mksquashfs requires a 2.6.29 kernel or better"
	use xz &&
		ewarn "XZ support requires a 2.6.38 kernel or better"
}
