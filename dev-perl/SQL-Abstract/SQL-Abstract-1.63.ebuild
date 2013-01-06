# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/SQL-Abstract/SQL-Abstract-1.63.ebuild,v 1.2 2010/04/17 08:28:22 tove Exp $

EAPI=2

MODULE_AUTHOR="RIBASUSHI"
#MODULE_AUTHOR="MSTROUT"
inherit perl-module

DESCRIPTION="Generate SQL from Perl data structures"

SLOT="0"
KEYWORDS="amd64 ~ppc x86 ~x86-solaris"
IUSE="test"

RDEPEND="dev-perl/Test-Deep"
DEPEND="${RDEPEND}
	test? ( dev-perl/Test-Exception
		dev-perl/Test-Pod
		dev-perl/Test-Warn
		>=dev-perl/Clone-0.31 )"

SRC_TEST="do"
