# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Data-ShowTable/Data-ShowTable-4.600.0.ebuild,v 1.1 2015/04/03 21:23:02 dilfridge Exp $

EAPI=5

MODULE_AUTHOR=AKSTE
MODULE_VERSION=4.6
inherit perl-module

DESCRIPTION="routines to display tabular data in several formats"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND="virtual/perl-ExtUtils-MakeMaker"

SRC_TEST=do
