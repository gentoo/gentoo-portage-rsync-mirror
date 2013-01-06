# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Cache-Memcached-Fast/Cache-Memcached-Fast-0.170.0.ebuild,v 1.1 2011/09/01 11:39:55 tove Exp $

EAPI=4

MODULE_AUTHOR=KROKI
MODULE_VERSION=0.17
inherit perl-module

DESCRIPTION="Perl client for memcached, in C language"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

SRC_TEST="do"

MAKEOPTS="${MAKEOPTS} -j1"
