# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Coro/Coro-6.230.0.ebuild,v 1.1 2012/12/08 14:52:47 tove Exp $

EAPI=4

MODULE_AUTHOR=MLEHMANN
MODULE_VERSION=6.23
inherit perl-module

DESCRIPTION="The only real threads in perl"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-perl/Event
	dev-perl/AnyEvent
	dev-perl/common-sense
	virtual/perl-Scalar-List-Utils
	dev-perl/EV
	dev-perl/AnyEvent
	virtual/perl-Storable
	virtual/perl-Time-HiRes
	dev-perl/Guard
	dev-perl/IO-AIO"

DEPEND="${RDEPEND}"

SRC_TEST="do"
