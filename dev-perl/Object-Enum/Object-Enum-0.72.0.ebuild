# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Object-Enum/Object-Enum-0.72.0.ebuild,v 1.1 2011/08/29 11:13:53 tove Exp $

EAPI=4

MODULE_AUTHOR=HDP
MODULE_VERSION=0.072
inherit perl-module

DESCRIPTION="Replacement for if (\$foo eq 'bar')"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-perl/Sub-Install
	dev-perl/Sub-Exporter
	dev-perl/Class-Data-Inheritable
	dev-perl/Class-Accessor"
RDEPEND="${DEPEND}"
