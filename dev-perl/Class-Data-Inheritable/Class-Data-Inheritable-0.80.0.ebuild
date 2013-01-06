# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Class-Data-Inheritable/Class-Data-Inheritable-0.80.0.ebuild,v 1.6 2012/09/01 11:18:28 grobian Exp $

EAPI=4

MODULE_AUTHOR=TMTM
MODULE_VERSION=0.08
inherit perl-module

DESCRIPTION="Inheritable, overridable class data"

SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 sparc x86 ~ppc-aix ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~x86-solaris"
IUSE=""

export OPTIMIZE="${CFLAGS}"
