# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/multimon/multimon-1.0-r3.ebuild,v 1.1 2012/12/16 09:40:26 lu_zero Exp $

EAPI=4

inherit eutils toolchain-funcs

DESCRIPTION="Decoding digital transmission codes"
HOMEPAGE="http://www.baycom.org/~tom/ham/linux/multimon.html"
SRC_URI="http://www.baycom.org/~tom/ham/linux/multimon.tar.gz
		 http://dev.gentoo.org/~lu_zero/distfiles/${P}-ubuntu.patch.xz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND="x11-libs/libX11"
DEPEND="${RDEPEND}
	x11-proto/xproto"

S=${WORKDIR}/multimon

src_prepare() {
	epatch \
		"${WORKDIR}"/${P}-ubuntu.patch \
		"${FILESDIR}"/${P}-flags.patch \
		"${FILESDIR}"/${P}-prll.patch \
		"${FILESDIR}"/${P}-includes.patch
	sed \
		-e '/^$(BINDIR)\//s:$: $(BINDIR):g' \
		-i Makefile || die
}

src_compile() {
	# bug #369713
	emake CFLAGS="${CFLAGS}" CC=$(tc-getCC)
}

src_install() {
	mv gen multimon-gen
	dobin multimon-gen mkcostab multimon
	doman multimon.1 multimon-gen.1
}

pkg_postinst() {
	ewarn "The gen command has been renamed to multimon-gen to avoid conflicts"
	ewarn "with dev-ruby/gen (#247156)"
}
