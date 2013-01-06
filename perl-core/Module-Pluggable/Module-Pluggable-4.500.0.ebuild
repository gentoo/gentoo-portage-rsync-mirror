# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/Module-Pluggable/Module-Pluggable-4.500.0.ebuild,v 1.1 2012/11/17 19:26:45 tove Exp $

EAPI=4

MODULE_AUTHOR=SIMONW
MODULE_VERSION=4.5
inherit perl-module

DESCRIPTION="automatically give your module the ability to have plugins"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~ppc-aix ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris ~x86-solaris"
IUSE=""

RDEPEND="virtual/perl-File-Spec"
DEPEND="${RDEPEND}
	virtual/perl-Module-Build
"

SRC_TEST="do"
