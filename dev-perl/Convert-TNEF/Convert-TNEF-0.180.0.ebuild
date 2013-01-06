# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Convert-TNEF/Convert-TNEF-0.180.0.ebuild,v 1.8 2012/10/28 19:36:32 armin76 Exp $

EAPI=4

MODULE_AUTHOR=DOUGW
MODULE_VERSION=0.18
inherit perl-module

DESCRIPTION="A Perl module for reading TNEF files"

SLOT="0"
KEYWORDS="alpha amd64 hppa ppc ppc64 sparc x86"
IUSE=""

RDEPEND="dev-perl/MIME-tools"
DEPEND="${RDEPEND}"

SRC_TEST=do
