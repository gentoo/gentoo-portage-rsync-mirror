# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Data-DumpXML/Data-DumpXML-1.60.0.ebuild,v 1.3 2012/06/09 22:11:17 chithanh Exp $

EAPI=4

MODULE_AUTHOR=GAAS
MODULE_VERSION=1.06
inherit perl-module

DESCRIPTION="Dump arbitrary data structures as XML"

SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ~mips ppc ppc64 sparc x86 ~sparc-solaris"
IUSE=""

RDEPEND=">=virtual/perl-MIME-Base64-2
	>=dev-perl/XML-Parser-2
	>=dev-perl/Array-RefElem-0.01"
DEPEND="${RDEPEND}"

SRC_TEST="do"
