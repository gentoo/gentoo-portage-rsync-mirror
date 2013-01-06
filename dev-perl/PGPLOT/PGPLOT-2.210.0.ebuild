# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/PGPLOT/PGPLOT-2.210.0.ebuild,v 1.2 2012/12/10 22:15:20 bicatali Exp $

EAPI=4

MODULE_AUTHOR=KGB
MODULE_VERSION=2.21
inherit perl-module

DESCRIPTION="allow subroutines in the PGPLOT graphics library to be called from Perl."

SLOT="0"
KEYWORDS="~amd64 ~ia64 ~x86 ~amd64-linux ~x86-linux"
IUSE=""

# Tests require active X display
#SRC_TEST="do"

RDEPEND="sci-libs/pgplot
	>=dev-perl/ExtUtils-F77-1.13"
DEPEND="${RDEPEND}"
