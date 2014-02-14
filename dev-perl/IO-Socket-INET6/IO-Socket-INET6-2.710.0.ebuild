# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/IO-Socket-INET6/IO-Socket-INET6-2.710.0.ebuild,v 1.5 2014/02/14 19:17:58 maekke Exp $

EAPI=4

MODULE_AUTHOR=SHLOMIF
MODULE_VERSION=2.71
inherit perl-module

DESCRIPTION="Work with IO sockets in ipv6"

SLOT="0"
KEYWORDS="~alpha ~amd64 arm hppa ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~x86-solaris"
IUSE=""

RDEPEND="dev-perl/Socket6"
DEPEND="${RDEPEND}
	virtual/perl-Module-Build"

# Disabling tests since they seem to be more trouble than worth, esp. in re bug
# 115004
#SRC_TEST="do"
