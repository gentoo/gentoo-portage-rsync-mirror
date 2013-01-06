# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/CGI-Builder/CGI-Builder-1.360.0.ebuild,v 1.1 2011/09/01 12:55:16 tove Exp $

EAPI=4

MODULE_AUTHOR=DOMIZIO
MODULE_VERSION=1.36
inherit perl-module

DESCRIPTION="Framework to build simple or complex web-apps"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-perl/OOTools-2.21
	>=dev-perl/IO-Util-1.5"
RDEPEND="${DEPEND}"
