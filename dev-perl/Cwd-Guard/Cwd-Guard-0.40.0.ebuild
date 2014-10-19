# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Cwd-Guard/Cwd-Guard-0.40.0.ebuild,v 1.1 2014/10/19 19:40:46 dilfridge Exp $

EAPI=5

MODULE_AUTHOR=KAZEBURO
MODULE_VERSION=0.04
inherit perl-module

DESCRIPTION="Temporary changing working directory (chdir)"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
# Cwd -> perl-File-Spec
RDEPEND="
	virtual/perl-File-Spec
	virtual/perl-Exporter
	virtual/perl-if
	virtual/perl-parent
"
# CPAN::Meta::Prereqs -> perl-CPAN-Meta
DEPEND="
	virtual/perl-CPAN-Meta
	>=virtual/perl-Module-Build-0.380.0
	${RDEPEND}
"

SRC_TEST="do"
