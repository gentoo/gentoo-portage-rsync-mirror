# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Time-Piece-MySQL/Time-Piece-MySQL-0.60.0.ebuild,v 1.1 2011/08/28 11:25:39 tove Exp $

EAPI=4

MODULE_AUTHOR=KASEI
MODULE_VERSION=0.06
inherit perl-module

DESCRIPTION="MySQL-specific functions for Time::Piece"

SLOT="0"
KEYWORDS="~amd64 ~x86 ~x86-solaris"
IUSE=""

RDEPEND=">=virtual/perl-Time-Piece-1.15"
DEPEND="${RDEPEND}"

SRC_TEST=do
