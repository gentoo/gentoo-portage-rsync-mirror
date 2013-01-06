# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Gearman/Gearman-1.110.0.ebuild,v 1.1 2011/08/30 15:14:07 tove Exp $

EAPI=4

MODULE_AUTHOR=DORMANDO
MODULE_VERSION=1.11
inherit perl-module

DESCRIPTION="Gearman distributed job system"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND="dev-perl/string-crc32"
RDEPEND="${DEPEND}"

mydoc="CHANGES HACKING TODO"
# testsuite requires gearman server
SRC_TEST="never"
