# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-Generator/XML-Generator-1.40.0.ebuild,v 1.8 2012/03/25 17:27:59 armin76 Exp $

EAPI=4

MODULE_AUTHOR=BHOLZMAN
MODULE_VERSION=1.04
inherit perl-module

DESCRIPTION="Perl XML::Generator - A module to help in generating XML documents"

SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh sparc x86"
IUSE=""

DEPEND="dev-libs/expat"
RDEPEND="${DEPEND}"

SRC_TEST="do"
