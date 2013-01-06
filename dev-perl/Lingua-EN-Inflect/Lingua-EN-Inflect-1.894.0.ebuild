# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Lingua-EN-Inflect/Lingua-EN-Inflect-1.894.0.ebuild,v 1.5 2012/10/02 00:04:21 blueness Exp $

EAPI=4

MODULE_AUTHOR=DCONWAY
MODULE_VERSION=1.894
inherit perl-module

DESCRIPTION='Perl module to pluralize English words'

SLOT="0"
KEYWORDS="amd64 ppc ppc64 x86"
IUSE=""

DEPEND="
	virtual/perl-Module-Build
"

SRC_TEST="do"
