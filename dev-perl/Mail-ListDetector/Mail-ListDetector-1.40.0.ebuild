# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Mail-ListDetector/Mail-ListDetector-1.40.0.ebuild,v 1.7 2012/06/17 14:10:19 armin76 Exp $

EAPI=4

MODULE_AUTHOR=MSTEVENS
MODULE_VERSION=1.04
inherit perl-module

DESCRIPTION="Perl extension for detecting mailing list messages"

SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

RDEPEND="dev-perl/URI
	dev-perl/Email-Valid
	dev-perl/Email-Abstract"
DEPEND="${RDEPEND}"

SRC_TEST="do"
