# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/AnyEvent-HTTP/AnyEvent-HTTP-2.140.0.ebuild,v 1.3 2012/08/03 11:02:46 ago Exp $

EAPI=4

MODULE_AUTHOR=MLEHMANN
MODULE_VERSION=2.14
inherit perl-module

DESCRIPTION="Simple but non-blocking HTTP/HTTPS client"

SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND=">=dev-perl/AnyEvent-6
	dev-perl/common-sense"
DEPEND="${RDEPEND}"

SRC_TEST="do"
