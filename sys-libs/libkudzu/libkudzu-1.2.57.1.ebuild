# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/libkudzu/libkudzu-1.2.57.1.ebuild,v 1.15 2011/04/15 03:14:58 jer Exp $

inherit eutils toolchain-funcs flag-o-matic

DESCRIPTION="Red Hat Hardware detection tools"
HOMEPAGE="http://rhlinux.redhat.com/kudzu/"
SRC_URI="mirror://gentoo/kudzu-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ia64 -mips ppc ppc64 sparc x86"
IUSE="zlib"

DEPEND="dev-libs/popt
	zlib? ( sys-libs/zlib )
	>=sys-apps/pciutils-2.2.4"
RDEPEND="${DEPEND}
	sys-apps/hwdata-gentoo
	!sys-apps/kudzu"

S=${WORKDIR}/kudzu-${PV}

src_unpack() {
	unpack ${A}

	epatch \
		"${FILESDIR}"/kudzu-${PV}-sbusfix.patch \
		"${FILESDIR}"/kudzu-${PV}-sparc-keyboard.patch
}

src_compile() {
	tc-export CC
	if use zlib
	then
		perl -pi -e 's| -lpci| -lz -lpci|g' Makefile
	elif built_with_use --missing false sys-apps/pciutils zlib
	then
		die "You need to build with USE=zlib to match sys-apps/pcituils"
	fi
	# Fix the modules directory to match Gentoo layout.
	perl -pi -e 's|/etc/modutils/kudzu|/etc/modules.d/kudzu|g' *.*

	if use ppc && [ "$(tc-arch-kernel)" != "ppc" ]; then
		emake libkudzu.a libkudzu_loader.a ARCH="ppc" \
			RPM_OPT_FLAGS="${CFLAGS}" || die
	else
		emake libkudzu.a libkudzu_loader.a ARCH=$(tc-arch-kernel) \
			RPM_OPT_FLAGS="${CFLAGS}" || die
	fi
}

src_install() {
	keepdir /etc/sysconfig
	insinto /usr/include/kudzu
	doins *.h
	dolib.a libkudzu.a libkudzu_loader.a
}
