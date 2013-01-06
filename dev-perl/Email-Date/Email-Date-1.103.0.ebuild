# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Email-Date/Email-Date-1.103.0.ebuild,v 1.8 2012/08/27 18:10:48 armin76 Exp $

EAPI=4

MODULE_AUTHOR=RJBS
MODULE_VERSION=1.103
inherit perl-module

DESCRIPTION="Find and Format Date Headers"

SLOT="0"
KEYWORDS="amd64 ppc ppc64 x86"
IUSE=""

RDEPEND=">=dev-perl/TimeDate-1.16
	>=dev-perl/Email-Abstract-2.13.1
	dev-perl/Email-Date-Format
	virtual/perl-Time-Local
	virtual/perl-Time-Piece"
DEPEND="${RDEPEND}"

SRC_TEST="do"
