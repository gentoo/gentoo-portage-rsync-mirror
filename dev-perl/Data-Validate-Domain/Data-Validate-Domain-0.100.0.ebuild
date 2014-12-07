# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Data-Validate-Domain/Data-Validate-Domain-0.100.0.ebuild,v 1.2 2014/12/07 13:22:31 zlogene Exp $

EAPI=5

MODULE_AUTHOR="NEELY"
MODULE_VERSION="0.10"

inherit perl-module

DESCRIPTION="Light weight module for validating domains"

LICENSE="|| ( Artistic GPL-1 GPL-2 GPL-3 )"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=">=dev-perl/Net-Domain-TLD-1.690.0"
