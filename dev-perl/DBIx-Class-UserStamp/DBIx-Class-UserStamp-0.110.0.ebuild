# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/DBIx-Class-UserStamp/DBIx-Class-UserStamp-0.110.0.ebuild,v 1.1 2011/08/31 13:36:43 tove Exp $

EAPI=4

MODULE_AUTHOR=JGOULAH
MODULE_VERSION=0.11
inherit perl-module

DESCRIPTION="Automatically set update and create user id fields"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-perl/Class-Accessor-Grouped
	dev-perl/DBIx-Class-DynamicDefault
	dev-perl/DBIx-Class"
RDEPEND="${DEPEND}"
