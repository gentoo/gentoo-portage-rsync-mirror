# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/unibilium/unibilium-1.1.2.ebuild,v 1.1 2015/02/26 05:54:55 yngwin Exp $

EAPI=5
inherit eutils flag-o-matic multilib

DESCRIPTION="A very basic terminfo library"
HOMEPAGE="https://github.com/mauke/unibilium/"
SRC_URI="http://dev.gentoo.org/~yngwin/distfiles/${P}.tar.xz"

LICENSE="LGPL-3+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-lang/perl
	sys-devel/libtool"
RDEPEND=""

src_compile() {
	append-flags -fPIC -fPIE
	emake PREFIX="${EPREFIX}/usr" LIBDIR="${EPREFIX}/usr/$(get_libdir)" all
}

src_install() {
	emake PREFIX="${EPREFIX}/usr" LIBDIR="${EPREFIX}/usr/$(get_libdir)" \
		DESTDIR="${D}" install
	prune_libtool_files
}
