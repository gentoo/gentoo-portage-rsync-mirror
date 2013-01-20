# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Net-SSH2/Net-SSH2-0.460.0.ebuild,v 1.1 2013/01/20 10:52:33 tove Exp $

EAPI=5

MODULE_AUTHOR=RKITOVER
MODULE_VERSION=0.46
inherit perl-module

DESCRIPTION="Net::SSH2 - Support for the SSH 2 protocol via libssh2."

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="net-libs/libssh2
>=virtual/perl-ExtUtils-MakeMaker-6.50"
DEPEND="${RDEPEND}"

SRC_TEST="do"
