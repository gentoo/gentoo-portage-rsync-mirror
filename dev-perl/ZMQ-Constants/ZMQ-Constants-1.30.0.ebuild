# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/ZMQ-Constants/ZMQ-Constants-1.30.0.ebuild,v 1.2 2014/03/28 13:23:41 jer Exp $

EAPI=5

MODULE_AUTHOR=DMAKI
MODULE_VERSION=1.03
inherit perl-module

DESCRIPTION="Constants for libzmq"

SLOT="0"
KEYWORDS="~amd64 hppa ~ppc ~ppc64 ~x86"

RDEPEND="
	net-libs/zeromq
"
DEPEND="${RDEPEND}"

SRC_TEST=do
