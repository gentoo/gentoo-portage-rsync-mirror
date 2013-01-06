# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Clone/Clone-0.310.0.ebuild,v 1.3 2012/09/01 11:23:21 grobian Exp $

EAPI=4

MODULE_AUTHOR=RDF
MODULE_VERSION=0.31
inherit perl-module

DESCRIPTION="Recursively copy Perl datatypes"

SLOT="0"
KEYWORDS="alpha amd64 ~arm hppa ia64 ~mips ppc ppc64 sparc x86 ~ppc-aix ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~x86-solaris"
IUSE=""

SRC_TEST="do"
mymake='OPTIMIZE=${CFLAGS}'
