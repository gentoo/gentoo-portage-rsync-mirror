# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/File-Find-Rule-Perl/File-Find-Rule-Perl-1.130.0.ebuild,v 1.1 2014/10/19 21:32:18 dilfridge Exp $

EAPI=5

MODULE_AUTHOR="ADAMK"
MODULE_VERSION=1.13

inherit perl-module

DESCRIPTION="Common rules for searching for Perl things"

LICENSE="|| ( Artistic GPL-1 GPL-2 GPL-3 )"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="
	>=dev-perl/File-Find-Rule-0.32
	dev-perl/Params-Util
"
