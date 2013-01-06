# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Digest-Perl-MD5/Digest-Perl-MD5-1.800.0.ebuild,v 1.13 2012/12/17 20:13:54 ago Exp $

EAPI=4

MODULE_AUTHOR=DELTA
MODULE_VERSION=1.8
inherit perl-module

DESCRIPTION="Pure perl implementation of MD5"

LICENSE="|| ( Artistic GPL-1 GPL-2 GPL-3 )"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc x86 ~ppc-aix ~amd64-fbsd ~x86-fbsd ~ppc-macos ~x64-macos ~x86-macos ~x64-solaris ~x86-solaris"
IUSE=""

SRC_TEST="do"
