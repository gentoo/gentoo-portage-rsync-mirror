# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/PodParser/PodParser-1.510.0.ebuild,v 1.13 2013/03/02 16:21:11 ago Exp $

EAPI=4

MY_PN=Pod-Parser
MODULE_AUTHOR=MAREKR
MODULE_VERSION=1.51
inherit perl-module

DESCRIPTION="Base class for creating POD filters and translators"
SRC_URI+=" http://dev.gentoo.org/~tove/distfiles/perl-core/PodParser/Pod-Parser-1.54-patch.tar.bz2"

SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~m68k ~mips ppc ppc64 s390 sh sparc x86 ~ppc-aix ~amd64-fbsd ~x86-fbsd ~x64-freebsd ~x86-freebsd ~hppa-hpux ~ia64-hpux ~x86-interix ~amd64-linux ~ia64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~m68k-mint ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE=""

SRC_TEST="do"

EPATCH_SUFFIX=patch
PATCHES=(
	"${WORKDIR}"/${MY_PN:-${PN}}-patch
)
