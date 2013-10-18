# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/gflags/gflags-2.0.ebuild,v 1.6 2013/10/18 22:12:08 vapier Exp $

EAPI="3"

DESCRIPTION="Google's C++ argument parsing library"
HOMEPAGE="http://code.google.com/p/gflags/"
SRC_URI="http://gflags.googlecode.com/files/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm ~mips ~ppc ~ppc64 x86 ~amd64-linux ~x86-linux"
IUSE="static-libs"

src_configure() {
	econf $(use_enable static-libs static)
}

src_install() {
	emake DESTDIR="${D}" install || die

	rm -rf "${ED}"/usr/share/doc/*
	dodoc AUTHORS ChangeLog NEWS README
	dohtml doc/*
}
