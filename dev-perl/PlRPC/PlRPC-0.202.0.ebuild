# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/PlRPC/PlRPC-0.202.0.ebuild,v 1.6 2012/09/01 11:49:30 grobian Exp $

EAPI=3

MODULE_AUTHOR=MNOONING
MODULE_SECTION=${PN}
MODULE_VERSION=0.2020
inherit perl-module

S=${WORKDIR}/${PN}

DESCRIPTION="The Perl RPC Module"

SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh sparc x86 ~ppc-aix ~amd64-fbsd ~x86-fbsd ~x64-freebsd ~x86-freebsd ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE=""

RDEPEND=">=virtual/perl-Storable-1.0.7
	>=dev-perl/Net-Daemon-0.34"
DEPEND="${RDEPEND}"

PATCHES=( "${FILESDIR}/perldoc-remove.patch" )
