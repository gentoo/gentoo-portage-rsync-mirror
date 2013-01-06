# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/config-general/config-general-2.500.0.ebuild,v 1.7 2012/10/21 18:19:54 armin76 Exp $

EAPI=4

MY_PN=Config-General
MODULE_AUTHOR=TLINDEN
MODULE_VERSION=2.50
inherit perl-module

DESCRIPTION="Config file parser module"

SLOT="0"
KEYWORDS="amd64 ~arm ppc ppc64 x86"
IUSE=""

SRC_TEST="do"
