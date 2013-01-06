# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Cache-Memcached/Cache-Memcached-1.26.ebuild,v 1.2 2011/07/30 10:21:00 tove Exp $

EAPI=2

MODULE_AUTHOR=BRADFITZ
inherit perl-module

DESCRIPTION="Perl API for memcached"
HOMEPAGE="http://www.danga.com/memcached/"

SRC_TEST="do"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE=""

DEPEND="dev-perl/string-crc32
	dev-lang/perl"
RDEPEND="${DEPEND}"

mydoc="ChangeLog README TODO"
