# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-LibXML-Iterator/XML-LibXML-Iterator-1.40.0.ebuild,v 1.2 2011/09/03 21:05:23 tove Exp $

EAPI=4

MODULE_AUTHOR=PHISH
MODULE_VERSION=1.04
inherit perl-module

DESCRIPTION="Iterator class for XML::LibXML parsed documents"

SLOT="0"
KEYWORDS="alpha amd64 ia64 ~ppc sparc x86"
IUSE=""

DEPEND="dev-perl/XML-LibXML
	dev-perl/XML-NodeFilter"
RDEPEND="${DEPEND}"

SRC_TEST="do"
