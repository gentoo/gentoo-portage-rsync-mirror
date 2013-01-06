# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/ZMQ-Constants/ZMQ-Constants-1.20.0.ebuild,v 1.1 2012/12/28 20:10:32 tove Exp $

EAPI=5

MODULE_AUTHOR=DMAKI
MODULE_VERSION=1.02
inherit perl-module

DESCRIPTION="Constants for libzmq"

SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~ppc64 ~x86"
IUSE=""

RDEPEND="
	net-libs/zeromq
"
DEPEND="${RDEPEND}"

SRC_TEST=do
