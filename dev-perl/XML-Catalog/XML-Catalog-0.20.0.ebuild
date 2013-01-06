# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-Catalog/XML-Catalog-0.20.0.ebuild,v 1.2 2011/09/03 21:04:24 tove Exp $

EAPI=4

MODULE_AUTHOR=EBOHLMAN
MODULE_VERSION=0.02
inherit perl-module

DESCRIPTION="Resolve public identifiers and remap system identifiers"

SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ppc sparc x86"
IUSE=""

RDEPEND=">=dev-perl/XML-Parser-2.29
	>=dev-perl/libwww-perl-5.48"
DEPEND="${RDEPEND}"
