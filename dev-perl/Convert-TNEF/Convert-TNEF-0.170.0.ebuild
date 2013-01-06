# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Convert-TNEF/Convert-TNEF-0.170.0.ebuild,v 1.3 2012/10/20 16:40:53 armin76 Exp $

EAPI=4

MODULE_AUTHOR=DOUGW
MODULE_VERSION=0.17
inherit perl-module

DESCRIPTION="A Perl module for reading TNEF files"

SLOT="0"
KEYWORDS="amd64 hppa ppc ppc64 x86"
IUSE=""

RDEPEND="dev-perl/MIME-tools"
DEPEND="${RDEPEND}"
