# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-Elemental/XML-Elemental-2.110.0.ebuild,v 1.2 2011/09/03 21:05:18 tove Exp $

EAPI=4

MODULE_AUTHOR=TIMA
MODULE_VERSION=2.11
inherit perl-module

DESCRIPTION="an XML::Parser style and generic classes for simplistic and perlish handling of XML data. "

LICENSE="Artistic"
SLOT="0"
KEYWORDS="amd64 hppa ia64 sparc x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris"
IUSE=""

DEPEND="dev-perl/XML-Parser
	dev-perl/XML-SAX
	dev-perl/Class-Accessor"
RDEPEND="${DEPEND}"

SRC_TEST="do"
