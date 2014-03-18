# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Readonly-XS/Readonly-XS-1.50.0.ebuild,v 1.10 2014/03/18 13:22:27 zlogene Exp $

EAPI=4

MODULE_AUTHOR=ROODE
MODULE_VERSION=1.05
inherit perl-module

DESCRIPTION="Companion module for Readonly.pm, to speed up read-only scalar variables"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE=""

RDEPEND="dev-perl/Readonly"
DEPEND="${RDEPEND}"

SRC_TEST=do
