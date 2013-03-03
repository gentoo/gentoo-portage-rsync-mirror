# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Net-DNS-Resolver-Programmable/Net-DNS-Resolver-Programmable-0.3.0.ebuild,v 1.4 2013/03/03 08:51:48 vapier Exp $

EAPI=4

MODULE_AUTHOR=JMEHNLE
MODULE_VERSION=v0.003
MODULE_SECTION=net-dns-resolver-programmable
inherit perl-module

DESCRIPTION="programmable DNS resolver class for offline emulation of DNS"

SLOT="0"
KEYWORDS="alpha amd64 ~arm hppa ia64 ppc ppc64 s390 sparc x86 ~x86-fbsd"
IUSE=""

RDEPEND="dev-perl/Net-DNS
	virtual/perl-version"
DEPEND="${RDEPEND}
	>=virtual/perl-Module-Build-0.33"

SRC_TEST="do"
