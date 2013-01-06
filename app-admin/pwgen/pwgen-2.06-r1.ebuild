# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/pwgen/pwgen-2.06-r1.ebuild,v 1.13 2012/10/14 21:52:18 aballier Exp $

EAPI="3"

inherit eutils toolchain-funcs

DESCRIPTION="Password Generator"
HOMEPAGE="http://sourceforge.net/projects/pwgen/"
SRC_URI="mirror://sourceforge/pwgen/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ~arm hppa ia64 ~mips ppc ppc64 sparc x86 ~amd64-fbsd ~x86-fbsd ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~x86-solaris"
IUSE="livecd"

src_prepare() {
	epatch "${FILESDIR}"/${PV}-special-char.patch
	sed -i -e 's:$(prefix)/man/man1:$(mandir)/man1:g' Makefile.in
}

src_configure() {
	tc-export CC
	econf --sysconfdir="${EPREFIX}"/etc/pwgen
}

src_install() {
	emake DESTDIR="${D}" install || die
	use livecd && newinitd "${FILESDIR}"/pwgen.rc pwgen
}
