# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-RSS-Parser/XML-RSS-Parser-4.0.0.ebuild,v 1.2 2011/09/03 21:04:45 tove Exp $

EAPI=4

MODULE_AUTHOR=TIMA
MODULE_VERSION=4.0
MY_S=${WORKDIR}/${PN}-${MODULE_VERSION/.0}
inherit perl-module

DESCRIPTION="A liberal object-oriented parser for RSS feeds"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="amd64 ia64 sparc x86"
IUSE=""

RDEPEND="dev-perl/Class-ErrorHandler
	>=dev-perl/Class-XPath-1.4
	>=dev-perl/XML-Elemental-2.0"
DEPEND="${RDEPEND}"

SRC_TEST="do"
