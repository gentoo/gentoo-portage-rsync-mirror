# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/rman/rman-3.2.ebuild,v 1.22 2012/05/09 16:12:19 aballier Exp $

EAPI="2"

inherit eutils toolchain-funcs

DESCRIPTION="PolyGlotMan man page translator AKA RosettaMan"
HOMEPAGE="http://sourceforge.net/projects/polyglotman/"
SRC_URI="mirror://sourceforge/polyglotman/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 sh sparc x86 ~amd64-fbsd ~x86-fbsd ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris ~x64-solaris ~x86-solaris"
IUSE=""
RESTRICT="test"

src_prepare() {
	epatch "${FILESDIR}"/${PF}-gentoo.diff || die "patch failed"
	epatch "${FILESDIR}/${P}-ldflags.patch"
}

src_compile() {
	emake CC="$(tc-getCC)" CFLAGS="${CFLAGS}" || die "emake failed"
}

src_install() {
	dobin ${PN} || die
	doman ${PN}.1 || die
}
