# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Lingua-Stem-Ru/Lingua-Stem-Ru-0.10.0.ebuild,v 1.2 2011/09/03 21:05:30 tove Exp $

EAPI=4

MODULE_AUTHOR=ALGDR
MODULE_VERSION=0.01
inherit perl-module

DESCRIPTION="Porter's stemming algorithm for Russian (KOI8-R only)"

SLOT="0"
KEYWORDS="amd64 ia64 ~ppc sparc x86"
IUSE=""

SRC_TEST="do"
