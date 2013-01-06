# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-block/btrace/btrace-0.0.20071210202527.ebuild,v 1.9 2011/02/07 07:30:58 kumba Exp $

inherit eutils toolchain-funcs flag-o-matic

DESCRIPTION="btrace can show detailed info about what is happening on a block device io queue."
HOMEPAGE="http://www.kernel.org/pub/linux/kernel/people/axboe/blktrace/"
# this is in case Jens ever releases a real version
MY_PV="git-${PV/0.0.}"
MY_PN="blktrace"
MY_P="${MY_PN}-${MY_PV}"
SRC_URI="http://brick.kernel.dk/snaps/${MY_P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="doc"
RDEPEND=""
# This is a Linux specific app!
DEPEND="${RDEPEND}
		sys-kernel/linux-headers
		doc? ( virtual/latex-base )
		dev-libs/libaio"
S="${WORKDIR}/${MY_PN}"

src_compile() {
	append-flags -DLVM_REMAP_WORKAROUND -W -I"${S}"
	emake CC="$(tc-getCC)" CFLAGS="${CFLAGS}" || die "emake failed"
	if use doc; then
		emake docs || die "emake docs failed"
	fi
}

src_install() {
	emake install DESTDIR="${D}" prefix="/usr" mandir="/usr/share/man" || die "emake install failed"
	dodoc README
	use doc && dodoc doc/blktrace.pdf
}
