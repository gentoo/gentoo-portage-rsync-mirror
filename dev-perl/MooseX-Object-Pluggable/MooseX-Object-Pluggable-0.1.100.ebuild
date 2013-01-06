# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/MooseX-Object-Pluggable/MooseX-Object-Pluggable-0.1.100.ebuild,v 1.1 2011/08/29 17:44:43 tove Exp $

EAPI=4

MODULE_AUTHOR=GRODITI
MODULE_VERSION=0.0011
inherit perl-module

DESCRIPTION="Make your classes pluggable"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="virtual/perl-Module-Pluggable
	dev-perl/Moose"
DEPEND="${RDEPEND}
	test? (
		dev-perl/Test-Pod
		dev-perl/Test-Pod-Coverage
	)"

SRC_TEST=do
