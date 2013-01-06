# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Test-MockTime/Test-MockTime-0.120.0.ebuild,v 1.1 2011/08/28 14:00:21 tove Exp $

EAPI=4

MODULE_AUTHOR=DDICK
MODULE_VERSION=0.12
inherit perl-module

DESCRIPTION="Replaces actual time with simulated time"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="virtual/perl-Time-Piece
	virtual/perl-Time-Local"
DEPEND="${RDEPEND}
	test? ( dev-perl/Test-Pod )"

SRC_TEST=do
