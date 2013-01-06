# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Class-DBI-Plugin-DeepAbstractSearch/Class-DBI-Plugin-DeepAbstractSearch-0.80.0.ebuild,v 1.1 2011/09/01 11:18:08 tove Exp $

EAPI=4

MODULE_AUTHOR=SRIHA
MODULE_VERSION=0.08
inherit perl-module

DESCRIPTION="deep_search_where() method for Class::DBI"

SLOT="0"
KEYWORDS="~amd64 ~x86 ~x86-solaris"
IUSE=""

RDEPEND=">=dev-perl/Class-DBI-Plugin-0.03
	>=dev-perl/SQL-Abstract-1.60
	dev-perl/Class-DBI"
DEPEND="${RDEPEND}"

SRC_TEST=do
