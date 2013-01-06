# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/HTML-LinkExtractor/HTML-LinkExtractor-0.130.0.ebuild,v 1.2 2011/09/03 21:04:49 tove Exp $

EAPI=4

MODULE_AUTHOR=PODMASTER
MODULE_VERSION=0.13
inherit perl-module

DESCRIPTION="A bare-bones HTML parser, similar to HTML::Parser, but with a couple important distinctions."

SLOT="0"
KEYWORDS="amd64 ia64 ppc ppc64 sparc x86"
IUSE=""

DEPEND="dev-perl/HTML-Parser"
RDEPEND="${DEPEND}
	dev-perl/URI"
