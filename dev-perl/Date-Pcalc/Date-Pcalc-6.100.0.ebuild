# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Date-Pcalc/Date-Pcalc-6.100.0.ebuild,v 1.3 2012/06/08 18:05:45 tove Exp $

EAPI=4

MODULE_AUTHOR=STBEY
MODULE_VERSION=6.1
inherit perl-module

DESCRIPTION="Gregorian calendar date calculations"

SLOT="0"
KEYWORDS="~alpha amd64 ~hppa ~ia64 ppc ~ppc64 ~s390 ~sparc x86"
IUSE=""

DEPEND=">=dev-perl/Bit-Vector-7
	>=dev-perl/Carp-Clan-5.3"
RDEPEND="${DEPEND}"

SRC_TEST="do"
mydoc="ToDo"
PATCHES=( "${FILESDIR}"/6.100.0_identifier_before_numeric_constant.patch )
