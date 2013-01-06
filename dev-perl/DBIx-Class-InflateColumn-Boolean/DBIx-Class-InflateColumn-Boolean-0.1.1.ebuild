# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/DBIx-Class-InflateColumn-Boolean/DBIx-Class-InflateColumn-Boolean-0.1.1.ebuild,v 1.1 2011/08/31 13:41:58 tove Exp $

EAPI=4

MODULE_AUTHOR=GRAF
MODULE_VERSION=0.001001
inherit perl-module

DESCRIPTION="Auto-create boolean objects from columns"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-perl/SQL-Translator
	dev-perl/Path-Class
	>=dev-perl/DBIx-Class-0.08107
	dev-perl/Contextual-Return"
RDEPEND="${DEPEND}"
