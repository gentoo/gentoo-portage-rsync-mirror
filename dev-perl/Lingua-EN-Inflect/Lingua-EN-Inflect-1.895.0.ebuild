# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Lingua-EN-Inflect/Lingua-EN-Inflect-1.895.0.ebuild,v 1.1 2013/08/17 12:49:41 patrick Exp $

EAPI=4

MODULE_AUTHOR=DCONWAY
MODULE_VERSION=1.895
inherit perl-module

DESCRIPTION='Perl module to pluralize English words'

SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE=""

DEPEND="
	virtual/perl-Module-Build
"

SRC_TEST="do"
