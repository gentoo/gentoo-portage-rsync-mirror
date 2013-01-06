# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/GDTextUtil/GDTextUtil-0.860.0.ebuild,v 1.2 2011/09/03 21:04:23 tove Exp $

EAPI=4

MODULE_AUTHOR=MVERB
MODULE_VERSION=0.86
inherit perl-module

DESCRIPTION="Text utilities for use with GD"

SLOT="0"
KEYWORDS="alpha amd64 ~arm ia64 ppc ppc64 sparc x86 ~x86-fbsd ~x86-solaris"
IUSE=""

RDEPEND="dev-perl/GD"
DEPEND="${RDEPEND}"
