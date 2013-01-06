# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/DBIx-Class-InflateColumn-Boolean/DBIx-Class-InflateColumn-Boolean-0.2.0.ebuild,v 1.1 2012/11/04 16:05:42 tove Exp $

EAPI=4

MODULE_AUTHOR=GRAF
MODULE_VERSION=0.002000
inherit perl-module

DESCRIPTION="Auto-create boolean objects from columns"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="
	dev-perl/SQL-Translator
	dev-perl/Path-Class
	>=dev-perl/DBIx-Class-0.81.70
	>=dev-perl/Contextual-Return-0.4.7
"
DEPEND="${RDEPEND}
	test? (
		dev-perl/Test-Pod
		dev-perl/Test-Pod-Coverage
	)
"

SRC_TEST=do
