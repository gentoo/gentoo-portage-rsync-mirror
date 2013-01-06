# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Net-Server-Coro/Net-Server-Coro-1.300.0.ebuild,v 1.1 2012/11/12 20:15:34 tove Exp $

EAPI=4

MODULE_AUTHOR=ALEXMV
MODULE_VERSION=1.3
inherit perl-module

DESCRIPTION="A co-operative multithreaded server using Coro"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="ssl"

RDEPEND="
	dev-perl/Coro
	dev-perl/AnyEvent
	>=dev-perl/net-server-2
	ssl? (
		dev-perl/Net-SSLeay
	)
"
DEPEND="${RDEPEND}"

SRC_TEST="do"
