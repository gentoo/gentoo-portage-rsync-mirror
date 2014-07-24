# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/Net-Ping/Net-Ping-2.36-r1.ebuild,v 1.1 2014/07/24 22:29:18 dilfridge Exp $

EAPI=5

MODULE_AUTHOR=SMPETERS
MY_PN=Net-Ping
MY_P=${MY_PN}-${PV}
S=${WORKDIR}/${MY_P}
inherit perl-module

DESCRIPTION="check a remote host for reachability"

SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 sparc x86 ~amd64-linux ~x86-linux ~x86-macos"
IUSE=""

# online tests
SRC_TEST=no
