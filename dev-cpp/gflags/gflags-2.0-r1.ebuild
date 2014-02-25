# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/gflags/gflags-2.0-r1.ebuild,v 1.1 2014/02/25 00:44:57 vapier Exp $

EAPI="5"

inherit multilib-minimal

DESCRIPTION="Google's C++ argument parsing library"
HOMEPAGE="http://code.google.com/p/gflags/"
SRC_URI="http://gflags.googlecode.com/files/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~amd64-linux ~x86-linux"
IUSE="static-libs"

multilib_src_configure() {
	ECONF_SOURCE=${S} econf $(use_enable static-libs static)
}

multilib_src_install_all() {
	rm -rf "${ED}"/usr/share/doc
	dodoc AUTHORS ChangeLog NEWS README
	dohtml doc/*
}
