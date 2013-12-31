# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/Switch/Switch-2.160.0.ebuild,v 1.5 2013/12/30 08:00:12 naota Exp $

EAPI=3

MODULE_AUTHOR=RGARCIA
MODULE_VERSION=2.16
inherit perl-module

DESCRIPTION="A switch statement for Perl"
SRC_URI+=" http://dev.gentoo.org/~tove/distfiles/perl-core/Switch/Switch-2.16-rt60380.patch"

SLOT="0"
KEYWORDS="~amd64 ~arm ~hppa ~ppc ~x86 ~x86-fbsd"
IUSE=""

SRC_TEST="do"
PATCHES=( "${DISTDIR}"/Switch-2.16-rt60380.patch )
