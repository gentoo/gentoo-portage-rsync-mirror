# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/HTML-Scrubber/HTML-Scrubber-0.90.0.ebuild,v 1.5 2012/03/02 21:36:08 ranger Exp $

EAPI=4

MODULE_AUTHOR=NIGELM
MODULE_VERSION=0.09
inherit perl-module

DESCRIPTION="Perl extension for scrubbing/sanitizing html"

SLOT="0"
KEYWORDS="amd64 ppc ppc64 x86"
IUSE=""

RDEPEND="dev-perl/HTML-Parser"
DEPEND="${REPEND}"

SRC_TEST="do"
