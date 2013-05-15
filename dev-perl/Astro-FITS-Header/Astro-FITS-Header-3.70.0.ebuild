# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Astro-FITS-Header/Astro-FITS-Header-3.70.0.ebuild,v 1.4 2013/05/15 14:14:45 ago Exp $

EAPI=5

MODULE_AUTHOR=TJENNESS
MODULE_VERSION=3.07
inherit perl-module

DESCRIPTION="Interface to FITS headers"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 ~arm ~hppa ~mips ~ppc x86 ~amd64-linux ~x86-linux"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}
	virtual/perl-Module-Build
"

SRC_TEST="do"
