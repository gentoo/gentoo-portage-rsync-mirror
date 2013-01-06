# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/SQL-Translator/SQL-Translator-0.110.120.ebuild,v 1.2 2012/09/01 11:50:47 grobian Exp $

EAPI=4

MODULE_AUTHOR=FREW
MODULE_VERSION=${PV:2:6}
MODULE_VERSION=${PV:0:1}.${MODULE_VERSION/.}
inherit perl-module

DESCRIPTION="Convert RDBMS SQL CREATE syntax"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86 ~ppc-aix ~x86-solaris"
IUSE="test"

RDEPEND="
	>=dev-perl/yaml-0.68
	>=dev-perl/IO-stringy-2.110
	dev-perl/Class-Base
	>=dev-perl/Digest-SHA1-2.12
	dev-perl/Class-Accessor
	>=dev-perl/Parse-RecDescent-1.967.9
	>=dev-perl/File-ShareDir-1.00
	dev-perl/Class-MakeMethods
	>=dev-perl/XML-Writer-0.606
	dev-perl/Carp-Clan
	dev-perl/Class-Data-Inheritable
	dev-perl/DBI
	dev-perl/Moo
"
DEPEND="${RDEPEND}
	test? (
		dev-perl/HTML-Parser
		>=dev-perl/XML-LibXML-1.69
		dev-perl/Spreadsheet-ParseExcel
		>=dev-perl/Template-Toolkit-2.2
		dev-perl/Test-Exception
		dev-perl/Test-Differences
		dev-perl/Test-Pod
	)
"

SRC_TEST=do
