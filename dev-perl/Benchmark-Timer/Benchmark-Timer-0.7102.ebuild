# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Benchmark-Timer/Benchmark-Timer-0.7102.ebuild,v 1.2 2014/01/12 23:40:18 civil Exp $

EAPI="5"

MODULE_AUTHOR="DCOPPIT"
MODULE_VERSION="0.7102"

inherit perl-module

DESCRIPTION="Perl code benchmarking tool"

LICENSE="|| ( Artistic GPL-1 GPL-2 GPL-3 )"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-perl/Statistics-TTest"
