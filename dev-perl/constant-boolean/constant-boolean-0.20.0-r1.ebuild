# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/constant-boolean/constant-boolean-0.20.0-r1.ebuild,v 1.1 2014/08/26 18:36:56 axs Exp $

EAPI=5

MODULE_AUTHOR=DEXTER
MODULE_VERSION=0.02
inherit perl-module

DESCRIPTION="Define TRUE and FALSE constants"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-perl/Symbol-Util"
DEPEND="virtual/perl-Module-Build"

SRC_TEST=do
