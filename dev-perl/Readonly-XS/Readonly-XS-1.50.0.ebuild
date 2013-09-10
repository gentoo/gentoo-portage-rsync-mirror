# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Readonly-XS/Readonly-XS-1.50.0.ebuild,v 1.2 2013/09/10 15:06:05 jer Exp $

EAPI=4

MODULE_AUTHOR=ROODE
MODULE_VERSION=1.05
inherit perl-module

DESCRIPTION="Companion module for Readonly.pm, to speed up read-only scalar variables"

SLOT="0"
KEYWORDS="~amd64 ~hppa ~x86"
IUSE=""

RDEPEND="dev-perl/Readonly"
DEPEND="${RDEPEND}"

SRC_TEST=do
