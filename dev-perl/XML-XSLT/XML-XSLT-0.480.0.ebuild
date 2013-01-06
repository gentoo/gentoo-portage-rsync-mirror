# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-XSLT/XML-XSLT-0.480.0.ebuild,v 1.2 2011/09/03 21:04:24 tove Exp $

EAPI=4

MODULE_AUTHOR=JSTOWE
MODULE_VERSION=0.48
inherit perl-module

DESCRIPTION="A Perl module to parse XSL Transformational sheets"

SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ppc sparc x86"
IUSE=""

RDEPEND=">=dev-perl/XML-Parser-2.29
	>=dev-perl/XML-DOM-1.25
	>=dev-perl/libwww-perl-5.48"
DEPEND="${RDEPEND}"

SRC_TEST="do"
