# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Boulder/Boulder-1.300.0.ebuild,v 1.2 2011/09/03 21:05:26 tove Exp $

EAPI=4

MODULE_AUTHOR=LDS
MODULE_VERSION=1.30
inherit perl-module

DESCRIPTION="An API for hierarchical tag/value structures"

SLOT="0"
KEYWORDS="amd64 ia64 ~ppc sparc x86"
IUSE=""

RDEPEND="dev-perl/XML-Parser"
DEPEND="${RDEPEND}"

SRC_TEST="do"
