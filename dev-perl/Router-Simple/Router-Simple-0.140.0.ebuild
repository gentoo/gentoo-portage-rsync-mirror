# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Router-Simple/Router-Simple-0.140.0.ebuild,v 1.1 2012/12/08 10:56:35 tove Exp $

EAPI=4

MODULE_AUTHOR=TOKUHIROM
MODULE_VERSION=0.14
inherit perl-module

DESCRIPTION="Simple HTTP router"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	virtual/perl-parent
	dev-perl/Class-Accessor-Lite
	virtual/perl-Scalar-List-Utils
"
DEPEND="${RDEPEND}
	virtual/perl-Module-Build
"

SRC_TEST=do
