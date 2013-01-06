# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/MooseX-MultiInitArg/MooseX-MultiInitArg-0.10.0.ebuild,v 1.2 2011/09/24 13:16:17 grobian Exp $

EAPI=4

MODULE_AUTHOR=FRODWITH
MODULE_VERSION=0.01
inherit perl-module

DESCRIPTION="Attributes with aliases for constructor arguments"

SLOT="0"
KEYWORDS="~amd64 ~x86 ~x64-macos"
IUSE="test"

RDEPEND="dev-perl/Moose"
DEPEND="test? ( ${DEPEND}
		dev-perl/Test-Pod )"

SRC_TEST="do"
