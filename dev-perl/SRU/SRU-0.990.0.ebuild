# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/SRU/SRU-0.990.0.ebuild,v 1.1 2011/08/29 09:35:43 tove Exp $

EAPI=4

MODULE_AUTHOR=BRICAS
MODULE_VERSION=0.99
inherit perl-module

DESCRIPTION="Catalyst::Controller::SRU - Dispatch SRU methods with Catalyst"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="
	dev-perl/URI
	dev-perl/XML-LibXML
	dev-perl/XML-Simple
	dev-perl/Class-Accessor
	>=dev-perl/CQL-Parser-1.0"
DEPEND="
	test? ( ${RDEPEND}
		dev-perl/Test-Exception )"

SRC_TEST=do
