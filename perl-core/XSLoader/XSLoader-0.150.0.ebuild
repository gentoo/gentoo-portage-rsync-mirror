# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/XSLoader/XSLoader-0.150.0.ebuild,v 1.7 2012/09/01 12:10:28 grobian Exp $

EAPI=4

MODULE_AUTHOR=SAPER
MODULE_VERSION=0.15
inherit perl-module

DESCRIPTION="Dynamically load C libraries into Perl code"
SRC_URI+=" http://dev.gentoo.org/~tove/distfiles/${CATEGORY}/${PN}/${P}-patch.tar.bz2"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm hppa ~ia64 ~mips ~ppc ~s390 ~sh ~sparc ~x86 ~ppc-aix ~x86-freebsd ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~x86-solaris"
IUSE=""

SRC_TEST=do

EPATCH_SUFFIX=patch
PATCHES=(
	"${WORKDIR}"/${MY_PN:-${PN}}-patch
)
