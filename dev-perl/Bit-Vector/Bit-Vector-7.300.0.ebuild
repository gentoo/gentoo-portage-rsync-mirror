# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Bit-Vector/Bit-Vector-7.300.0.ebuild,v 1.1 2014/09/12 17:38:15 zlogene Exp $

EAPI=5

MODULE_AUTHOR=STBEY
MODULE_VERSION=7.3
inherit perl-module

DESCRIPTION="Efficient bit vector, set of integers and big int math library"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~ia64 ~m68k ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE=""

RDEPEND="dev-perl/Carp-Clan
	>=virtual/perl-Storable-2.20"
DEPEND="${RDEPEND}"

SRC_TEST="do"
