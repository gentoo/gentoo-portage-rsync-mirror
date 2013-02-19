# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/Memoize/Memoize-1.30.0.ebuild,v 1.4 2013/02/18 23:41:41 ago Exp $

EAPI=4

MODULE_AUTHOR=MJD
MODULE_VERSION=1.03
MODULE_A_EXT=tgz
inherit perl-module

DESCRIPTION="Generic Perl function result caching system"

SLOT="0"
KEYWORDS="~alpha amd64 ~hppa ~ia64 ppc ~sparc x86 ~amd64-linux ~x86-linux ~x86-macos"
IUSE=""

SRC_TEST=do
