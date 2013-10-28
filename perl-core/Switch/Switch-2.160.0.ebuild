# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/Switch/Switch-2.160.0.ebuild,v 1.4 2013/10/28 19:56:58 jer Exp $

EAPI=3

MODULE_AUTHOR=RGARCIA
MODULE_VERSION=2.16
inherit perl-module

DESCRIPTION="A switch statement for Perl"
SRC_URI+=" http://dev.gentoo.org/~tove/distfiles/perl-core/Switch/Switch-2.16-rt60380.patch"

SLOT="0"
KEYWORDS="~amd64 ~arm ~hppa ~ppc ~x86"
IUSE=""

SRC_TEST="do"
PATCHES=( "${DISTDIR}"/Switch-2.16-rt60380.patch )
