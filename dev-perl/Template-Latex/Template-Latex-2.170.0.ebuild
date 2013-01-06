# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Template-Latex/Template-Latex-2.170.0.ebuild,v 1.4 2012/09/02 18:06:07 armin76 Exp $

EAPI=4

MODULE_AUTHOR=ANDREWF
MODULE_VERSION=2.17
inherit perl-module eutils

DESCRIPTION="Template::Latex - Latex support for the Template Toolkit"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="amd64 ~arm ppc ppc64 x86 ~x86-fbsd ~x86-solaris"
IUSE="test"

RDEPEND=">=dev-perl/Template-Toolkit-2.15
	virtual/perl-File-Spec
	virtual/latex-base"
DEPEND="${RDEPEND}
	test? ( virtual/perl-Test-Harness )"

SRC_TEST="do"
PATCHES=( "${FILESDIR}/Makefile.patch" )
