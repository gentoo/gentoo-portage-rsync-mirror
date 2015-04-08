# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/IMAP-BodyStructure/IMAP-BodyStructure-1.10.0.ebuild,v 1.1 2014/09/25 10:05:48 chainsaw Exp $

EAPI=5

MODULE_AUTHOR="KAPPA"
MODULE_VERSION="1.01"

inherit perl-module

DESCRIPTION="IMAP4-compatible BODYSTRUCTURE and ENVELOPE parser"

LICENSE="|| ( Artistic GPL-1 GPL-2 GPL-3 )"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="dev-perl/Test-NoWarnings
	dev-lang/perl
	virtual/perl-Module-Build"
