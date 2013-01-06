# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-Dumper/XML-Dumper-0.810.0.ebuild,v 1.2 2011/09/03 21:04:56 tove Exp $

EAPI=4

MODULE_AUTHOR=MIKEWONG
MODULE_VERSION=0.81
inherit perl-module

DESCRIPTION="Perl module for dumping Perl objects from/to XML"

SLOT="0"
KEYWORDS="amd64 hppa ia64 ppc sparc x86"
IUSE=""

RDEPEND=">=dev-perl/XML-Parser-2.16"
DEPEND="${RDEPEND}"

SRC_TEST="do"
