# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/Module-Load-Conditional/Module-Load-Conditional-0.400.ebuild,v 1.4 2014/01/20 20:58:30 vapier Exp $

EAPI=3

MODULE_AUTHOR=BINGOS
MODULE_VERSION=0.40
inherit perl-module

DESCRIPTION="Looking up module information / loading at runtime"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~ia64 ~m68k ~ppc ~s390 ~sh ~sparc ~x86"
IUSE=""

DEPEND=">=virtual/perl-Module-Load-0.12
	>=virtual/perl-Module-CoreList-0.22
	virtual/perl-Locale-Maketext-Simple
	virtual/perl-Params-Check
	virtual/perl-version"
RDEPEND="${DEPEND}"

SRC_TEST=do
