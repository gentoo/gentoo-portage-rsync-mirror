# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Class-WhiteHole/Class-WhiteHole-0.40.0.ebuild,v 1.2 2011/09/03 21:05:01 tove Exp $

EAPI=4

MODULE_AUTHOR=MSCHWERN
MODULE_VERSION=0.04
inherit perl-module

DESCRIPTION="base class to treat unhandled method calls as errors"

SLOT="0"
KEYWORDS="amd64 ia64 ~ppc ppc64 sparc x86 ~x86-solaris"
IUSE=""

SRC_TEST="do"
