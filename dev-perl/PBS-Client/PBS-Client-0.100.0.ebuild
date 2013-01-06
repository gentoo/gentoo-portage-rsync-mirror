# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/PBS-Client/PBS-Client-0.100.0.ebuild,v 1.1 2012/12/10 19:25:08 tove Exp $

EAPI=4

MODULE_AUTHOR=KWMAK
MODULE_SECTION=PBS/Client
MODULE_VERSION=0.10
inherit perl-module

DESCRIPTION="Perl interface to submit jobs to PBS (Portable Batch System)"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

SRC_TEST="do"
