# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Readonly/Readonly-1.30.0.ebuild,v 1.9 2014/02/03 21:03:22 zlogene Exp $

EAPI=4

MODULE_AUTHOR=ROODE
MODULE_VERSION=1.03
inherit perl-module

DESCRIPTION="Facility for creating read-only scalars, arrays, hashes"

SLOT="0"
KEYWORDS="~alpha amd64 ~arm ~hppa ~ia64 ppc ~ppc64 ~s390 sparc x86 ~ppc-aix ~amd64-linux ~x86-linux ~ppc-macos ~x86-solaris"
IUSE=""

SRC_TEST="do"
