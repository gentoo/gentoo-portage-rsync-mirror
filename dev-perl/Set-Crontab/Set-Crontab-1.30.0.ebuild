# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Set-Crontab/Set-Crontab-1.30.0.ebuild,v 1.1 2013/09/12 14:18:45 dev-zero Exp $

EAPI=5

MODULE_AUTHOR="AMS"
MODULE_VERSION="1.03"

inherit perl-module

DESCRIPTION="Expand crontab(5)-style integer lists"

SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND=""
DEPEND="virtual/perl-ExtUtils-MakeMaker"

SRC_TEST="do"
