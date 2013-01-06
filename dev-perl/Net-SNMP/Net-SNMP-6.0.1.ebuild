# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Net-SNMP/Net-SNMP-6.0.1.ebuild,v 1.9 2012/09/01 11:44:24 grobian Exp $

EAPI=3

MY_P=${PN}-v${PV}
S=${WORKDIR}/${MY_P}
MODULE_AUTHOR=DTOWN
inherit perl-module

DESCRIPTION="A SNMP Perl Module"

SLOT="0"
KEYWORDS="alpha amd64 ~arm hppa ia64 ~mips ppc ppc64 sparc x86 ~ppc-aix ~sparc-solaris ~x86-solaris"
IUSE=""

RDEPEND="
	>=dev-perl/Crypt-DES-2.03
	>=virtual/perl-Digest-MD5-2.11
	>=dev-perl/Digest-SHA1-1.02
	>=dev-perl/Digest-HMAC-1.0
	>=virtual/perl-libnet-1.0703"
DEPEND="${RDEPEND}
	virtual/perl-Module-Build"

SRC_TEST=do
