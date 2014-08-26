# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Coro/Coro-6.310.0-r1.ebuild,v 1.1 2014/08/26 17:15:04 axs Exp $

EAPI=5

MODULE_AUTHOR=MLEHMANN
MODULE_VERSION=6.31
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
