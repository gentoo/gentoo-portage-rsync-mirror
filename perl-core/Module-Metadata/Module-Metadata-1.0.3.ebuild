# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/Module-Metadata/Module-Metadata-1.0.3.ebuild,v 1.4 2011/01/30 18:03:59 armin76 Exp $

EAPI=3

MODULE_AUTHOR=DAGOLDEN
MODULE_VERSION=1.000003
inherit perl-module

DESCRIPTION="Gather package and POD information from perl module files"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~s390 ~sh ~sparc ~x86"
IUSE=""

RDEPEND=">=virtual/perl-version-0.870"
DEPEND="${RDEPEND}"

SRC_TEST="do"
