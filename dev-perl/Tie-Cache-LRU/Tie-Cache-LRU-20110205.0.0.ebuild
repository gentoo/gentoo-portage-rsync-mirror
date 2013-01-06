# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Tie-Cache-LRU/Tie-Cache-LRU-20110205.0.0.ebuild,v 1.1 2011/08/28 11:50:36 tove Exp $

EAPI=4

MODULE_AUTHOR=MSCHWERN
MODULE_VERSION=20110205
inherit perl-module

DESCRIPTION="A Least-Recently Used cache"

SLOT="0"
KEYWORDS="~amd64 ~x86 ~x86-solaris"
IUSE="test"

RDEPEND="dev-perl/enum
	dev-perl/Carp-Assert
	dev-perl/Class-Virtual
	dev-perl/Class-Data-Inheritable"
DEPEND="${RDEPEND}
	test? ( >=virtual/perl-Test-Simple-0.82 )"

SRC_TEST=do
