# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Sub-Identify/Sub-Identify-0.40.0-r1.ebuild,v 1.1 2014/08/22 20:18:34 axs Exp $

EAPI=5

MODULE_AUTHOR=RGARCIA
MODULE_VERSION=0.04
inherit perl-module

DESCRIPTION="Retrieve names of code references"

SLOT="0"
KEYWORDS="amd64 ppc x86 ~ppc-macos ~x64-macos ~x86-solaris"
IUSE="test"

RDEPEND=""
DEPEND="${RDEPEND}
	test? ( dev-perl/Test-Pod )"

SRC_TEST=do
