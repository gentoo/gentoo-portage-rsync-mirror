# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/UltraDNS/UltraDNS-0.60.0.ebuild,v 1.1 2011/08/28 09:38:24 tove Exp $

EAPI=4

MODULE_AUTHOR=TIMB
MODULE_VERSION=0.06
inherit perl-module

DESCRIPTION="Client API for the NeuStar UltraDNS Transaction Protocol"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-perl/Net-SSLeay-1.35
	dev-perl/Test-Exception
	dev-perl/RPC-XML
	dev-perl/XML-LibXML"
RDEPEND="${DEPEND}"

SRC_TEST="do"

mydoc="NUS_API_XML.errata"
