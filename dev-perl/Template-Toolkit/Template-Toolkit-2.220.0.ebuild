# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Template-Toolkit/Template-Toolkit-2.220.0.ebuild,v 1.4 2012/09/02 18:05:15 armin76 Exp $

EAPI=4

MODULE_AUTHOR=ABW
MODULE_VERSION=2.22
inherit perl-module

DESCRIPTION="The Template Toolkit"

SLOT="0"
KEYWORDS="~amd64 ~arm ~ppc ~ppc64 ~x86 ~x86-fbsd ~x86-solaris"
IUSE="xml gd mysql postgres latex vim-syntax"

RDEPEND="dev-perl/text-autoformat
	mysql? ( dev-perl/DBD-mysql )
	postgres? ( dev-perl/DBD-Pg )
	>=dev-perl/AppConfig-1.56"
DEPEND="${RDEPEND}"
PDEPEND="dev-perl/text-autoformat
	vim-syntax? ( app-vim/tt2-syntax )
	xml? ( dev-perl/Template-XML )
	gd? ( dev-perl/Template-GD )
	mysql? ( dev-perl/Template-DBI )
	latex? ( dev-perl/Template-Latex )
	postgres? ( dev-perl/Template-DBI )"

#The installer tries to install to /usr/local/tt2...,
#and asks for user input, so we change myconf to ensure that
# 1) make install doesn't violate the sandbox rule
# 2) perl Makefile.pl just uses reasonable defaults, and doesn't ask for input
myconf="TT_XS_ENABLE=y TT_ACCEPT=y TT_QUIET=y
	TT_DOCS=y TT_SPLASH_DOCS=y TT_EXAMPLES=y
	TT_PREFIX=${D%/}${EPREFIX}/usr/share/template-toolkit2
	TT_IMAGES=/usr/share/template-toolkit2/images"

mydoc="README"

SRC_TEST=do
