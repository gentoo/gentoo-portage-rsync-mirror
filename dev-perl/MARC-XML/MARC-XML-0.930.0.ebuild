# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/MARC-XML/MARC-XML-0.930.0.ebuild,v 1.1 2011/08/30 11:11:51 tove Exp $

EAPI=4

MODULE_AUTHOR=GMCHARLT
MODULE_VERSION=0.93
inherit perl-module

DESCRIPTION="A subclass of MARC.pm to provide XML support"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND="dev-perl/XML-SAX
	dev-perl/MARC-Charset
	dev-perl/MARC-Record"
DEPEND="${RDEPEND}"

SRC_TEST=do
