# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/text-template/text-template-1.460.0.ebuild,v 1.6 2013/12/27 17:35:20 zlogene Exp $

EAPI=4

MY_PN=Text-Template
MODULE_AUTHOR=MJD
MODULE_VERSION=1.46
inherit perl-module

DESCRIPTION="Expand template text with embedded Perl"

LICENSE="|| ( Artistic GPL-2 GPL-3 )" # Artistic or GPL-2+
SLOT="0"
KEYWORDS="alpha amd64 hppa ppc x86 ~ppc-macos"
IUSE=""

SRC_TEST=do
