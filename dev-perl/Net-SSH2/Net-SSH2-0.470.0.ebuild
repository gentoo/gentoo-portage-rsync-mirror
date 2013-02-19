# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Net-SSH2/Net-SSH2-0.470.0.ebuild,v 1.1 2013/02/19 16:00:19 tove Exp $

EAPI=5

MODULE_AUTHOR=RKITOVER
MODULE_VERSION=0.47
inherit perl-module

DESCRIPTION="Net::SSH2 - Support for the SSH 2 protocol via libssh2."

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gcrypt"

RDEPEND="
	sys-libs/zlib
	net-libs/libssh2
	!gcrypt? (
		dev-libs/openssl
	)
	gcrypt? (
		dev-libs/libgcrypt
	)
"
DEPEND="${RDEPEND}
	>=virtual/perl-ExtUtils-MakeMaker-6.50
"

SRC_TEST="do"

src_configure() {
	use gcrypt && myconf=gcrypt
	perl-module_src_configure
}
