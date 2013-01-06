# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/AnyEvent-HTTP/AnyEvent-HTTP-2.150.0.ebuild,v 1.1 2012/11/18 19:38:26 tove Exp $

EAPI=4

MODULE_AUTHOR=MLEHMANN
MODULE_VERSION=2.15
inherit perl-module

DESCRIPTION="Simple but non-blocking HTTP/HTTPS client"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-perl/AnyEvent-6
	dev-perl/common-sense"
DEPEND="${RDEPEND}"

SRC_TEST="do"
