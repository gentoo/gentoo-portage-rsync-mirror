# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/File-Copy-Link/File-Copy-Link-0.113.0-r1.ebuild,v 1.1 2014/08/26 18:20:15 axs Exp $

EAPI=5

MODULE_AUTHOR=RMBARKER
MODULE_VERSION=0.113
inherit perl-module

DESCRIPTION="Perl extension for replacing a link by a copy of the linked file"

SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="virtual/perl-File-Spec"
DEPEND="virtual/perl-Module-Build
	virtual/perl-File-Temp
	${RDEPEND}"

SRC_TEST="do"
